//
//  TabBarReducer.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import ComposableArchitecture

@Reducer
struct TabBarReducer {
    @ObservableState
    struct State: Equatable {
        var tabBarItemType: TabBarItemType = .topics
    }

    enum Action: Equatable {
        case setTabBarItemType(TabBarItemType)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .setTabBarItemType(let type):
                state.tabBarItemType = type
                return .none
            }
        }
    }
}
