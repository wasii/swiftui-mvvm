//
//  MovieListDetailViewModel.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 25/03/2022.
//

import Foundation

class MoviesDetailViewModal: ObservableObject {
    @Published private var moviewDetailModal: MovieDetailModal?
    @Published var loadingStates = LoadingState.loading
    
    
    private var httpClient = NetworkManager()
    init(movieDetailModal: MovieDetailModal? = nil) {
        self.moviewDetailModal = moviewDetailModal
    }
    
    var title: String {
        moviewDetailModal?.title ?? ""
    }
    var plot: String {
        moviewDetailModal?.plot ?? ""
    }
    var poster: String {
        moviewDetailModal?.poster ?? ""
    }
    var rating: Int {
        get {
            let ratingAsDouble = moviewDetailModal?.imdbRating ?? "0.0"
            return Int((ratingAsDouble as NSString).integerValue)
        }
    }
    var director: String {
        moviewDetailModal?.director ?? ""
    }
    
    func getMovieDetail(id: String) {
        if id.isEmpty {
            self.loadingStates = .failed
            return
        }
        self.loadingStates = .loading
        httpClient.fetchData(url: URL.forMovieDetail(by: id), requesttype: .get, type: MovieDetailModal.self, params: nil) { response in
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.moviewDetailModal = model
                    self.loadingStates = .success
                }
                
                break
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
