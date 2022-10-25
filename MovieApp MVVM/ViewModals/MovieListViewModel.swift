//
//  MovieListViewModel.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import Foundation

class MovieListViewModal: ViewModalBase {
    
    @Published var movies = [MovieViewModal]()
    let httpClient = NetworkManager()
    
    func searchByName(_ name: String) {
        if name.isEmpty {
            return
        }
        self.loadingStates = .loading
        httpClient.fetchData(url: URL.forMoviesByName(by: name), requesttype: .get, type: MovieResponse.self, params: nil) { response in
            switch response {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.movies = movieResponse.movies.map(MovieViewModal.init)
                    self.loadingStates = .success
                }
            case .failure(.BadURL):
                DispatchQueue.main.async {
                    self.loadingStates = .failed
                }
                break
            case .failure(.NoData):
                DispatchQueue.main.async {
                    self.loadingStates = .failed
                }
                break
            case .failure(.DecodingError):
                DispatchQueue.main.async {
                    self.loadingStates = .failed
                }
                break
            }
        }
    }
}

struct MovieViewModal {
    let movie: Movie
    
    var title: String {
        movie.title
    }
    var imdbId: String {
        movie.imdbID
    }
    var poster: String {
        movie.poster
    }
    var year: String {
        movie.year
    }
}
