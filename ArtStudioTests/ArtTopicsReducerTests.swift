//
//  ArtTopicsReducerTests.swift
//  ArtTopicsReducerTests
//
//  Created by stone on 2024/11/22.
//

import XCTest
import ComposableArchitecture
@testable import ArtStudio

final class ArtTopicsReducerTests: XCTestCase {
    func testTopics() async {
        let mockDate = Date()
        let store = await TestStore(initialState: TopicsReducer.State()) {
            TopicsReducer()
        } withDependencies: {
            $0.dataManager = DataManager.mock()
            $0.artApiClient = MockApiClient()
            $0.coreDataClient = MockCoreDataClient()
            $0.dateClient = DateClient(now: { mockDate })
        }
        
        await store.send(.initData) {
            $0.inited = true
        }
        
        await store.receive(.fetchTopics) {
            $0.loading = true
        }
        
        await store.receive(.topicsResponse([MockApiClient.mockTopic1, MockApiClient.mockTopic2])) {
            $0.loading = false
            $0.topics = [MockApiClient.mockTopic1, MockApiClient.mockTopic2]
            $0.selectedTopicIndex = 0
            $0.artTopicPhotos = [TopicsReducer.ArtTopicPhotoInfo(page: 0, photos: []),
                                 TopicsReducer.ArtTopicPhotoInfo(page: 0, photos: [])]
        }
        
        await store.receive(.saveTopics)
        
        await store.receive(.saveFetchedTopicDate) {
            $0.fetchedTopicDate = mockDate
        }
        
        await store.receive(.fetchTopicPhotos) {
            $0.loading = true
        }
        
        await store.receive(.topicPhotosResponse([MockApiClient.mockPhoto])) {
            $0.loading = false
            $0.artTopicPhotos = [TopicsReducer.ArtTopicPhotoInfo(page: 1, photos: [MockApiClient.mockPhoto]),
                                 TopicsReducer.ArtTopicPhotoInfo(page: 0, photos: [])]
        }
    }
}
