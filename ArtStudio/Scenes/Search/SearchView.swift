//
//  SearchView.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import ComposableArchitecture
import WaterfallGrid
import Kingfisher
import SwiftUI

struct SearchView: View {
    @Bindable var store: StoreOf<SearchReducer>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    TextField(L10n.SearchView.Textfield.Placehold.searchPhotos, text: $store.query)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .submitLabel(.search)
                        .onSubmit {
                            store.send(.searchButtonTapped)
                        }
                    Spacer()
                    Button(L10n.SearchView.Button.search) {
                        store.send(.searchButtonTapped)
                    }
                    .padding()
                }
                
                Text(store.displayType.title)
                    .font(.title)
                
                ScrollView(.vertical, showsIndicators: false) {
                    WaterfallGrid(store.photos, id: \.self) { photo in
                        NavigationLink {
                            PhotoView(store: Store(initialState: PhotoReducer.State(photo: photo), reducer: {
                                PhotoReducer()
                            }))
                        } label: {
                            KFImage(URL(string: photo.urls?.thumb ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipped()
                        }
                    }
                    .gridStyle(columns: 3)
                }
                Spacer()
                FetchMoreFooter(loading: store.loading) {
                    store.send(.fetchMore)
                }
            }
            .padding()
            .overlay(
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .opacity(store.loading ? 1 : 0)
            )
        }
        .alert(isPresented: Binding<Bool>(
            get: { store.error != nil },
            set: { _ in store.send(.setError(nil)) })
        ) {
            Alert(title: Text(L10n.Common.Alert.Title.error),
                  message: Text(store.error?.message ?? ""),
                  dismissButton: .default(Text(L10n.Common.Alert.Button.ok)))
        }
        .onAppear {
            if !store.loaded {
                store.send(.fetchData)
            }
        }
    }
}

#Preview {
    SearchView(store: Store(initialState: SearchReducer.State(), reducer: {
        SearchReducer()
    }))
}

enum DisplayType: Equatable {
    case discover
    case search
    
    var title: String {
        switch self {
        case .discover:
            return L10n.Enum.Search.DisplayType.discover
        case .search:
            return L10n.Enum.Search.DisplayType.search
        }
    }
}
