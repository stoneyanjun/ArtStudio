//
//  TabBarView.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import ComposableArchitecture
import SwiftUI

struct TabBarView: View {
    @Bindable var store: StoreOf<AppReducer>
    
    var body: some View {
        ZStack {
            TabView(
                selection: .init(
                    get: { store.tabBarState.tabBarItemType },
                    set: { store.send(.tabBar(.setTabBarItemType($0))) }
                )
            ) {
                ForEach(TabBarItemType.allCases) { type in
                    Group {
                        switch type {
                        case .topics:
                            TopicsView(store: store.scope(state: \.topicsState, action: \.topics))
                        case .search:
                            SearchView(store: store.scope(state: \.searchState, action: \.search))
                        }
                    }
                    .tabItem(type.label).tag(type)
                }
            }
        }
    }
}

#Preview {
    TabBarView(store: Store(initialState: AppReducer.State(), reducer: {
        AppReducer()
    }))
}

// MARK: TabType
enum TabBarItemType: Int, CaseIterable, Equatable, Identifiable {
    var id: Int { rawValue }
    
    case topics
    case search
}

extension TabBarItemType {
    var title: String {
        switch self {
        case .topics:
            return L10n.Enum.Tabbar.topics
        case .search:
            return L10n.Enum.Tabbar.search
        }
    }
    var symbol: String {
        switch self {
        case .topics:
            return "list.dash"
        case .search:
            return "magnifyingglass.circle"
        }
    }
    func label() -> Label<Text, Image> {
        Label(title, systemImage: symbol)
    }
}
