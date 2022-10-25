//
//  MovieDetailScreen.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 25/03/2022.
//

import SwiftUI

struct MovieDetailScreen: View {
    let imdbId: String
    @ObservedObject var movieDetailViewModel = MoviesDetailViewModal()
    var body: some View {
        VStack {
            if movieDetailViewModel.loadingStates == .loading {
                LoadingView()
            } else if movieDetailViewModel.loadingStates == .failed {
                NoDataFound()
            } else if movieDetailViewModel.loadingStates == .success {
                MovieDetailView(movieDetail: movieDetailViewModel)
            }
        }
        .onAppear {
            self.movieDetailViewModel.getMovieDetail(id: self.imdbId)
        }
    }
}

