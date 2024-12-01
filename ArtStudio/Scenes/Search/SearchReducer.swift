//
//  SearchReducer.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import ComposableArchitecture

@Reducer
struct SearchReducer {
    @ObservableState
    struct State: Equatable {
        var displayType: DisplayType = .discover
        var error: ArtError?
        var loading = false
        var loaded = false
        var photoPage = 1
        var photos: [ArtPhoto] = []
        var query = ""
        var queryPage = 1
        var searchPhotoResponse: SearchPhotoResponse?
    }
    
    enum Action: BindableAction, Equatable  {
        case binding(BindingAction<State>)
        case fetchData
        case fetchMore
        case fetchPhotos
        case photoSearchResult(response: SearchPhotoResponse)
        case photosResponse(photos: [ArtPhoto])
        case search(query: String)
        case searchButtonTapped
        case setError(ArtError?)
    }
    
    @Dependency(\.artApiClient) var artApiClient
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
              return .none
            case .fetchData:
                state.loaded = true
                return .run { send in
                    await send(.fetchPhotos)
                }
            case .fetchMore:
                if state.displayType == .discover {
                    return .run { send in
                        await send(.fetchPhotos)
                    }
                } else {
                    let query = state.query
                    return .run { send in
                        await send(.search(query: query))
                    }
                }
            case .fetchPhotos:
                state.loading = true
                let page = state.photoPage
                return .run { send in
                    do {
                        let photos = try await artApiClient.fetchPhotos(page: page)
                        await send(.photosResponse(photos: photos))
                    } catch {
                        await send(.setError(ArtError(message: error.localizedDescription)))
                    }
                }
            case .photoSearchResult(let response):
                state.searchPhotoResponse = response
                state.photos.append(contentsOf: response.results ?? [])
                state.queryPage += 1
                state.loading = false
                return .none
            case .photosResponse(let photos):
                state.photoPage += 1
                state.photos.append(contentsOf: photos)
                state.loading = false
                return .none
            case .search(let query):
                guard !state.loading else { return .none }
                state.loading = true
                let param = SearchPhotoParam(query: query, page: state.queryPage)
                return .run { send in
                    do {
                        let response = try await artApiClient.searchPhotos(with: param)
                        await send(.photoSearchResult(response: response))
                    } catch {
                        await send(.setError(ArtError(message: error.localizedDescription)))
                    }
                }
            case .searchButtonTapped:
                guard !state.query.isEmpty else { return .none }
                state.searchPhotoResponse = nil
                state.queryPage = 1
                state.displayType = .search
                state.photos = []
                let query = state.query
                return .run { send in
                    await send(.search(query: query))
                }
            case .setError(let error):
                state.error = error
                state.loading = false
                return .none
            }
        }
    }
}
