//
//  HomeReducer.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import CoreData
import Foundation
import ComposableArchitecture

@Reducer
struct TopicsReducer {
    @Dependency(\.artApiClient) var artApiClient
    @Dependency(\.dataManager) var dataManager
    @Dependency(\.coreDataClient) var coreDataClient
    @Dependency(\.dateClient) var dateClient
    
    @ObservableState
    struct State: Equatable {
        var artTopicPhotos: [ArtTopicPhotoInfo] = []
        var error: ArtError?
        var inited = false
        var loading = false
        var selectedTopicIndex = -1
        var topics: [ArtTopic] = []
        var fetchedTopicDate: Date?
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case fetchTopicPhotos
        case fetchTopics
        case initData
        case saveFetchedTopicDate
        case saveTopics
        case selectTopic(ArtTopic)
        case setError(ArtError?)
        case topicPhotosResponse([ArtPhoto])
        case topicsResponse([ArtTopic])
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .fetchTopics:
                state.loading = true
                return .run { send in
                    do {
                        let topics = try await artApiClient.fetchTopics(page: 1)
                        await send(.topicsResponse(topics))
                    } catch {
                        await send(.setError(ArtError(message: error.localizedDescription)))
                    }
                }
            case .fetchTopicPhotos:
                let selectedTopicIndex = state.selectedTopicIndex
                guard !state.loading,
                      selectedTopicIndex >= 0,
                      selectedTopicIndex < state.topics.count,
                      selectedTopicIndex < state.artTopicPhotos.count,
                      let topicID = state.topics[selectedTopicIndex].id else { return .none }
                
                state.loading = true
                let page = state.artTopicPhotos[state.selectedTopicIndex].page
                return .run { send in
                    do {
                        let photos = try await artApiClient.fetchTopicPhotos(with: topicID, page: page)
                        await send(.topicPhotosResponse(photos))
                    } catch {
                        await send(.setError(ArtError(message: error.localizedDescription)))
                    }
                }
            case .initData:
                state.inited = true
                state.fetchedTopicDate = coreDataClient.loadFetchedTopicDate()
                
                do {
                    @Dependency(\.dataManager.load) var load
                    state.topics = try JSONDecoder().decode([ArtTopic].self, from: load(.topics))
                } catch {
                    state.topics = []
                }
                state.artTopicPhotos = Array(repeating: ArtTopicPhotoInfo(), count: state.topics.count)
                state.selectedTopicIndex = state.artTopicPhotos.isEmpty ? -1 : 0
                
                let shouldRefreshTopics = shouldRefreshTopics(with: state.fetchedTopicDate) || state.topics.isEmpty
                let newAction: Action = shouldRefreshTopics ? .fetchTopics : .fetchTopicPhotos
                return .run { send in
                    await send(newAction)
                }
            case .saveFetchedTopicDate:
                let newDate = dateClient.now()
                state.fetchedTopicDate = newDate
                coreDataClient.updateFetchedTopicDate(to: newDate)
                return .none
            case .saveTopics:
                do {
                    try dataManager.save(
                        JSONEncoder().encode(state.topics),
                        .topics
                    )
                } catch {}
                return .none
            case .selectTopic(let topic):
                if let index = state.topics.firstIndex(where: {
                    $0 == topic
                }) {
                    state.selectedTopicIndex = index
                    if state.artTopicPhotos[index].photos.isEmpty {
                        return .run { send in
                            await send(.fetchTopicPhotos)
                        }
                    }
                }
                return .none
            case .setError(let error):
                state.error = error
                state.loading = false
                return .none
            case .topicPhotosResponse(let photos):
                guard state.selectedTopicIndex < state.artTopicPhotos.count else { return .none }
                state.artTopicPhotos[state.selectedTopicIndex].page += 1
                state.artTopicPhotos[state.selectedTopicIndex].photos.append(contentsOf: photos)
                state.loading = false
                return .none
            case .topicsResponse(let topics):
                state.topics = topics
                state.artTopicPhotos = Array(repeating: ArtTopicPhotoInfo(), count: state.topics.count)
                state.selectedTopicIndex = state.artTopicPhotos.isEmpty ? -1 : 0
                state.loading = false
                return .run { send in
                    await send(.saveTopics)
                    await send(.saveFetchedTopicDate)
                    await send(.fetchTopicPhotos)
                }
            }
        }
    }
    
    struct ArtTopicPhotoInfo: Equatable {
        var page: Int = 0
        var photos: [ArtPhoto] = []
    }
}

extension TopicsReducer.State {
    var selectedTopic: ArtTopic? {
        return selectedTopicIndex >= 0 && selectedTopicIndex < topics.count ? topics[selectedTopicIndex] : nil
    }
    
    var photos: [ArtPhoto] {
        guard selectedTopicIndex >= 0,
              selectedTopicIndex < artTopicPhotos.count else { return [] }
        return artTopicPhotos[selectedTopicIndex].photos
    }
}

extension TopicsReducer {
    private func shouldRefreshTopics(with fetchedTopicDate: Date?) -> Bool {
        guard let fetchedDate = fetchedTopicDate else { return true }
        let threeDays: TimeInterval = 3 * 24 * 60 * 60
        return Date().timeIntervalSince(fetchedDate) > threeDays
    }
}
