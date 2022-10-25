//
//  ImageLoader.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import Foundation
class ImageLoader: ObservableObject {
    @Published var downloadedImage: Data?
    
    func downloadImage(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedImage = data
            }
        }.resume()
    }
}
