//
//  ArtClient.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import ComposableArchitecture
import Foundation
import Moya

protocol ApiClientProtocol {
    func fetchPhoto(with photoID: String) async throws -> ArtPhoto
    func fetchPhotos(page: Int) async throws -> [ArtPhoto]
    func fetchTopicPhotos(with topicID: String, page: Int) async throws -> [ArtPhoto]
    func fetchTopics(page: Int) async throws -> [ArtTopic]
    func searchPhotos(with searchPhotoParam: SearchPhotoParam) async throws -> SearchPhotoResponse
}

class ArtApiClient: ApiClientProtocol {
    private let provider: MoyaProvider<ArtApiService>
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    init(provider: MoyaProvider<ArtApiService> = MoyaProvider<ArtApiService>()) {
        self.provider = provider
    }
    
    func fetchPhoto(with photoID: String) async throws -> ArtPhoto {
        let response = try await provider.requestAsync(.photo(photoID: photoID))
        return try decoder.decode(ArtPhoto.self, from: response.data)
    }
    
    func fetchPhotos(page: Int) async throws -> [ArtPhoto] {
        let response = try await provider.requestAsync(.photos(page: page))
        return try decoder.decode([ArtPhoto].self, from: response.data)
    }
    
    func fetchTopicPhotos(with topicID: String, page: Int) async throws -> [ArtPhoto] {
        let response = try await provider.requestAsync(.topicPhotos(topicID: topicID, page: page))
        return try decoder.decode([ArtPhoto].self, from: response.data)
    }
    
    func fetchTopics(page: Int) async throws -> [ArtTopic] {
        let response = try await provider.requestAsync(.topics(page: page))
        return try decoder.decode([ArtTopic].self, from: response.data)
    }
    
    func searchPhotos(with searchPhotoParam: SearchPhotoParam) async throws -> SearchPhotoResponse {
        let response = try await provider.requestAsync(.searchPhotos(searchPhotoParam: searchPhotoParam))
        return try decoder.decode(SearchPhotoResponse.self, from: response.data)
    }
}

extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                    print("requestAsync: \(response.request?.url?.absoluteString ?? "")")
                    if let str = String(data: response.data, encoding: .utf8) {
                        print("requestAsync data: \r\n\(str)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct ArtApiClientKey: DependencyKey {
    static let liveValue: ApiClientProtocol = ArtApiClient()
}

extension DependencyValues {
    var artApiClient: ApiClientProtocol {
        get { self[ArtApiClientKey.self] }
        set { self[ArtApiClientKey.self] = newValue }
    }
}
