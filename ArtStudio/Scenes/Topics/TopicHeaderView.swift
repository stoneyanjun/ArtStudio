//
//  TopicHeaderView.swift
//  ArtStudio
//
//  Created by stone on 2024/11/25.
//

import SwiftUI

struct TopicHeaderView: View {
    let topic: ArtTopic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(topic.title ?? "")
                .font(.title)
            HStack {
                Text(topic.description ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
