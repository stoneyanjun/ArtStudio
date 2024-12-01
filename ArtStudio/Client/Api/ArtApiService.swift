//
//  ArtApiService.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import Moya
import SwiftUI

enum ArtApiService {
    case photo(photoID: String)
    case photos(page: Int)
    case searchPhotos(searchPhotoParam: SearchPhotoParam)
    case topicPhotos(topicID: String, page: Int)
    case topics(page: Int)
}

extension ArtApiService: TargetType {
    private enum Constants {
        static let ArtAccessKey = "j43G4Q8_jCSTriUYgpdUQXrWgSgbwqHnRVjTgAV2mIo"
        static let ArtServerAddress = "https://api.unsplash.com/"
        static let perPage = 10
    }
    
    var baseURL: URL {
        URL(string: Constants.ArtServerAddress)!
    }
    
    var path: String {
        switch self {
        case .photo(let photoID):
            return "photos/\(photoID)"
        case .photos:
            return "photos"
        case .searchPhotos:
            return "search/photos"
        case .topicPhotos(let topicID, _):
            return "topics/\(topicID)/photos"
        case .topics:
            return "topics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .photos(let page):
            parameters["page"] = page
            parameters["per_page"] = Constants.perPage
        case .searchPhotos(let searchPhotoParam):
            parameters["query"] = searchPhotoParam.query
            parameters["page"] = searchPhotoParam.page
            parameters["per_page"] = Constants.perPage
            parameters["order_by"] = searchPhotoParam.orderBy?.rawValue
            parameters["collections"] = searchPhotoParam.collectionIDs
            parameters["content_filter"] = searchPhotoParam.contentFilter?.rawValue
            parameters["color"] = searchPhotoParam.color?.rawValue
            parameters["orientation"] = searchPhotoParam.orientation?.rawValue
        case .topicPhotos(_, let page):
            parameters["page"] = page
            parameters["per_page"] = Constants.perPage
        case .topics(let page):
            parameters["page"] = page
            parameters["per_page"] = Constants.perPage
            parameters["featured"] = true
            parameters["open"] = true
        default:
            return .requestPlain
        }
        
        return .requestParameters(
            parameters: parameters,
            encoding: URLEncoding.queryString
        )
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Client-ID \(Constants.ArtAccessKey)"]
    }
}
