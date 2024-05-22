//
//  UserDetailView.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import SwiftUI
import SFSafeSymbols

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewMdoel
    
    var body: some View {
        switch viewModel.viewState {
            case .loading:
                loadingView()
            case .loaded:
                contentView()
            case .error(let error):
                errorView(with: error)
        }
    }
    
    private func loadingView() -> some View {
        return VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    private func contentView() -> some View {
        return VStack {
            Spacer()
            AsyncLoadingImageView(url: viewModel.imageURL)
            
            Text(viewModel.userName)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                if let starsCount = viewModel.numberOfStars {
                    Text(String(describing: starsCount))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else {
                    ProgressView()
                }
            }
            Spacer()
        }
    }
    
    private func errorView(with error: Error) -> some View {
        return VStack {
            Spacer()
            Image(systemName: SFSymbol.xmarkCircle.rawValue)
                .padding()
            Text(error.localizedDescription)
                .font(.subheadline)
            Spacer()
        }
    }

}
