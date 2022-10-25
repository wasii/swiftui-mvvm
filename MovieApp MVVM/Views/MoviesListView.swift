//
//  MoviesListView.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import SwiftUI

struct MoviesListView: View {
    var movies: [MovieViewModal]
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        return List(self.movies, id: \.imdbId) { movie in
            NavigationLink {
                MovieDetailScreen(imdbId: movie.imdbId)
            } label: {
                MoviesListCell(movie: movie)
                    .listRowSeparator(.hidden)
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(movies: [
            MovieViewModal(movie: Movie(title: "a", year: "a", imdbID: "a", type: "a", poster: "a"))
        ])
    }
}


struct MoviesListCell: View {
    let movie: MovieViewModal
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                URLImage(url: movie.poster, placeholder: "placeholder")
                    .frame(width: 135, height: 135, alignment: .leading)
                    .clipShape(Circle())
                VStack (alignment: .leading) {
                    Text(movie.title).fontWeight(.semibold)
                    Text(movie.year)
                }
            }
        }
    }
}
