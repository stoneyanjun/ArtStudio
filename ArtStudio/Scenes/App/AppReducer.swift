//
//  AppReducer.swift
//  ArtStudio
//
//  Created by stone on 2024/11/29.
//

import ComposableArchitecture

@Reducer
struct AppReducer {
    @ObservableState
    struct State: Equatable {
        var searchState = SearchReducer.State()
        var tabBarState = TabBarReducer.State()
        var topicsState = TopicsReducer.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case search(SearchReducer.Action)
        case tabBar(TabBarReducer.Action)
        case topics(TopicsReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .search:
                return .none
            case .tabBar:
                return .none
            case .topics:
                return .none
            }
        }
        
        Scope(state: \.searchState, action: \.search, child: SearchReducer.init)
        Scope(state: \.tabBarState, action: \.tabBar, child: TabBarReducer.init)
        Scope(state: \.topicsState, action: \.topics, child: TopicsReducer.init)
    }
}
