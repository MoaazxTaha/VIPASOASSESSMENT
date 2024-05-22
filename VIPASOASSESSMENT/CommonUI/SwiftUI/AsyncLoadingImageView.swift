//
//  AsyncLoadingImage.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 22/05/2024.
//

import SwiftUI

struct AsyncLoadingImageView: View {
    var url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .circleImageStyle()
            } else if phase.error != nil {
                Text(Strings.emptyViewMessage)
                    .padding()
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .padding()
            }
        }
    }
}




