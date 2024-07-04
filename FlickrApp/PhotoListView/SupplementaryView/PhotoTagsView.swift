//
//  PhotoTagsView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 03/07/2024.
//

import SwiftUI

struct PhotoTagsView: View {
    let rows = [GridItem(.flexible(minimum: 1, maximum: 100))]

    var tags: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { text in
                    Text(text)
                        .font(.footnote)
                        .padding(4)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
    }
}

#Preview {
    PhotoTagsView(tags: ["birds", "storks", "water", "nature"])
}
