//
//  ContentView.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                NetworkManager().fetchData(url: URL.forMoviesByName(by: "batman"), requesttype: .get, type: MovieResponse.self, params: nil) { response in
                    switch response {
                    case .success(let movies):
                        print(movies.movies)
                        break
                    case .failure(.DecodingError):
                        break
                    case .failure(.NoData):
                        break
                    case .failure(.BadURL):
                        break
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
