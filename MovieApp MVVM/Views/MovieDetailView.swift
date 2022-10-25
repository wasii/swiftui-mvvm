//
//  MovieDetailView.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 25/03/2022.
//

import SwiftUI

struct MovieDetailView: View {
    let movieDetail: MoviesDetailViewModal
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                URLImage(url: movieDetail.poster, placeholder: "placeholder")
                    .cornerRadius(10)
                Text(movieDetail.title)
                    .font(.title)
                    .lineLimit(2)
                Text(movieDetail.plot)
                Text("Director \(movieDetail.director)")
                HStack {
                    Rating(rating: .constant(movieDetail.rating))
                    Text("\(movieDetail.rating)/10")
                }.padding(.top, 10)
                
                Spacer()
            }.padding()
                .navigationTitle(movieDetail.title)
        }
    }
}
