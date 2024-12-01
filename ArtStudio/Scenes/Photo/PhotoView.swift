//
//  PhotoView.swift
//  ArtStudio
//
//  Created by stone on 2024/11/25.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

struct PhotoView: View {
    let store: StoreOf<PhotoReducer>
    @State private var isPhotoVisible = false
    
    var body: some View {
        VStack {
            if let url = URL(string: store.photo.urls?.regular ?? "") {
                ZStack {
                    KFImage(url)
                        .placeholder {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        .onSuccess { _ in
                            isPhotoVisible = true
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5), value: isPhotoVisible)
                        .onAppear {
                            isPhotoVisible = false // Reset state when the view appears
                        }
                        .onTapGesture {
                        }
                }
                .background(Color.black)
            }
        }
    }
}
