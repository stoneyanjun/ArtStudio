//
//  FetchMoreFooter.swift
//  ArtStudio
//
//  Created by stone on 2024/11/26.
//

import SwiftUI

struct FetchMoreFooter: View {
    private let loading: Bool
    private let fetchMoreAction: (() -> Void)?

    init(loading: Bool, fetchMoreAction: (() -> Void)?) {
        self.loading = loading
        self.fetchMoreAction = fetchMoreAction
    }

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ZStack {
                Button {
                    fetchMoreAction?()
                } label: {
                    Image(systemName: "arrowtriangle.down.circle")
                        .foregroundStyle(.red).imageScale(.large)
                }
                .opacity(loading ? 0 : 1)
            }
            Spacer()
        }
        .frame(height: 50)
    }
}
