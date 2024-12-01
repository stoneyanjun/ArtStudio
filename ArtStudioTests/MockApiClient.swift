//
//  MockApiClient.swift
//  ArtStudio
//
//  Created by stone on 2024/11/30.
//

import XCTest
import ComposableArchitecture
@testable import ArtStudio

class MockApiClient: ApiClientProtocol {
    static let mockPhoto = ArtPhoto(slug: nil, color: nil, location: nil, likes: nil, tags: [], assetType: nil, downloads: nil, updatedAt: nil, publicDomain: nil, views: nil, links: nil, relatedCollections: nil, meta: nil, id: "photo12345678", topicSubmissions: nil, likedByUser: nil, user: nil, exif: nil, alternativeSlugs: nil, promotedAt: nil, height: nil, width: nil, urls: ArtPhoto.Urls(raw: nil, full: nil, thumb: "https://th.bing.com/th/id/OIP.VXdImxhZLCEOavLJBoyz-QHaH6?rs=1&pid=ImgDetMain", smallS3: nil, regular: nil, small: nil), createdAt: nil, blurHash: nil, altDescription: nil, sponsorship: nil, description: nil)
    
    static let mockTopic1 = ArtTopic(slug: nil, status: nil, title: "night", publishedAt: nil, updatedAt: nil, visibility: nil, endsAt: nil, totalPhotos: 10, links: nil, previewPhotos: [], coverPhoto: nil, id: "topic111", onlySubmissionsAfter: nil, mediaTypes: [], totalCurrentUserSubmissions: nil, startsAt: nil, featured: nil, owners: [], description: "night image")
    
    static let mockTopic2 = ArtTopic(slug: nil, status: nil, title: "Wallpaper", publishedAt: nil, updatedAt: nil, visibility: nil, endsAt: nil, totalPhotos: 10, links: nil, previewPhotos: [], coverPhoto: nil, id: "topic22", onlySubmissionsAfter: nil, mediaTypes: [], totalCurrentUserSubmissions: nil, startsAt: nil, featured: nil, owners: [], description: "Popular Wallpaper")
    
    static let mockSearchPhotoResponse = SearchPhotoResponse(total: 1, totalPages: 1, results: [mockPhoto])
    
    func fetchPhoto(with photoID: String) async throws -> ArtPhoto {
        MockApiClient.mockPhoto
    }
    
    func fetchPhotos(page: Int) async throws -> [ArtPhoto] {
        [MockApiClient.mockPhoto]
    }
    
    func fetchTopicPhotos(with topicID: String, page: Int) async throws -> [ArtPhoto] {
        [MockApiClient.mockPhoto]
    }
    
    func fetchTopics(page: Int) async throws -> [ArtTopic] {
        [MockApiClient.mockTopic1, MockApiClient.mockTopic2]
    }
    
    func searchPhotos(with searchPhotoParam: SearchPhotoParam) async throws -> SearchPhotoResponse {
        MockApiClient.mockSearchPhotoResponse
    }
}
