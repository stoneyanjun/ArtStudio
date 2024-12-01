//
//  ArtStudioApp.swift
//  ArtStudio
//
//  Created by stone on 2024/11/22.
//

import ComposableArchitecture
import SwiftUI

@main
struct ArtStudioApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView(store: Store(initialState: AppReducer.State(), reducer: {
                AppReducer()
            }))
        }
    }
}
