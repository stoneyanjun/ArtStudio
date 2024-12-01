//
//  TopicsView.swift
//  ArtStudio
//
//  Created by stone on 2024/11/23.
//

import ComposableArchitecture
import WaterfallGrid
import Kingfisher
import SwiftUI

struct TopicsView: View {
    @Bindable var store: StoreOf<TopicsReducer>
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(store.topics) { topic in
                            Button(action: {
                                store.send(.selectTopic(topic))
                            }) {
                                Text(topic.title ?? L10n.Common.Title.unknown)
                                    .font(.footnote)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                                    .background(store.selectedTopic == topic ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(store.selectedTopic == topic ? .white : .black)
                                    .cornerRadius(6)
                            }
                        }
                        .frame(minWidth: 10)
                    }
                }
                
                if let topic = store.selectedTopic {
                    TopicHeaderView(topic: topic)
                        .padding(.bottom)
                }
                
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
                    store.send(.fetchTopicPhotos)
                }
            }
            .padding(10)
            .overlay(
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .opacity(store.loading ? 1 : 0)
            )
            .alert(isPresented: Binding<Bool>(
                get: { store.error != nil },
                set: { _ in store.send(.setError(nil)) })
            ) {
                Alert(title: Text(L10n.Common.Alert.Title.error),
                      message: Text(store.error?.message ?? L10n.Common.Alert.Message.unknown),
                      dismissButton: .default(Text(L10n.Common.Alert.Button.ok)))
            }
        }
        .navigationTitle(L10n.Common.title)
        .onAppear {
            if !store.inited {
                store.send(.initData)
            }
        }
    }
}

#Preview {
    TopicsView(store: Store(initialState: TopicsReducer.State(), reducer: {
        TopicsReducer()
    }))
}
