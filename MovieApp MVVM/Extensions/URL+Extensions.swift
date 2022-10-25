//
//  URL+Extensions.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import Foundation

extension URL {
    static func forMoviesByName(by movie: String) -> URL? {
        return URL(string: "https://www.omdbapi.com/?s=\(movie)&apikey=\(Constant.APIKEY)")
    }
    
    static func forMovieDetail(by id: String) -> URL? {
        return URL(string: "https://www.omdbapi.com/?i=\(id)&apikey=\(Constant.APIKEY)")
    }
}
