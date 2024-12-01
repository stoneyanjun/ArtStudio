//
//  PhotoReducer.swift
//  ArtStudio
//
//  Created by stone on 2024/11/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PhotoReducer {
    @ObservableState
    struct State: Equatable {
        var photo: ArtPhoto
    }
    
    enum Action: Equatable {
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }
}
