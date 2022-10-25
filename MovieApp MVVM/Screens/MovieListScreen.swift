//
//  MovieListScreen.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import SwiftUI

struct MovieListScreen: View {
    @ObservedObject private var movieListViewModel: MovieListViewModal
    @State var movieName: String = ""
    init() {
        self.movieListViewModel = MovieListViewModal()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search Movie by Name", text: $movieName) {
                self.movieListViewModel.searchByName(self.movieName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
                .navigationTitle("Movies")
            if self.movieListViewModel.loadingStates == .loading {
                LoadingView()
            } else if self.movieListViewModel.loadingStates == .success {
                MoviesListView(movies: self.movieListViewModel.movies)
            } else if self.movieListViewModel.loadingStates == .failed {
                NoDataFound()
            }
                
        }.padding().embedNavigationView()
    }
}

struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieListScreen()
    }
}
