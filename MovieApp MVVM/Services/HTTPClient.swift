//
//  HTTPClient.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import Foundation

enum APIError: Error {
    case BadURL
    case DecodingError
    case NoData
}
enum RequestType: String {
    case get    = "GET"
    case post   = "POST"
}

class NetworkManager: NSObject {
    let aPICalling:      APICalling
    let responseHandler: ResponseHandler
    
    init(aPICalling: APICalling = APICalling(),
         responseHandler: ResponseHandler = ResponseHandler()) {
        self.responseHandler = responseHandler
        self.aPICalling = aPICalling
    }
    
    func fetchData<T: Codable>(url: URL?, requesttype: RequestType, type: T.Type, params: [String:Any]?, onCompletion: @escaping(Result<T, APIError>) -> Void) {
        guard let url = url else {
            onCompletion(.failure(.BadURL))
            return
        }
        self.aPICalling.callServer(url: url, requesttype: requesttype, params: params) { result in
            switch result {
            case .success(let data):
                self.responseHandler.handleResponse(type: type, data: data) { decoded in
                    switch decoded {
                    case .success(let model):
                        onCompletion(.success(model))
                    case .failure(_):
                        onCompletion(.failure(.DecodingError))
                    }
                }
                break
            case .failure(_):
                onCompletion(.failure(.NoData))
            }
        }
    }
}

class APICalling {
    func callServer(url: URL, requesttype:RequestType, params: [String:Any]?, onCompletion: @escaping(Result<Data, APIError>) -> Void) {
        var request = URLRequest(url: url)
        switch requesttype {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            if let httpBody = try? JSONSerialization.data(withJSONObject: params ?? [:], options: []) {
                request.httpBody = httpBody
            }
        }
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                return onCompletion(.failure(.NoData))
            }
            onCompletion(.success(data))
        }.resume()
    }
}

class ResponseHandler {
    func handleResponse<T:Codable>(type: T.Type, data: Data, onCompletion: @escaping(Result<T, APIError>) -> Void) {
        if let response = try? JSONDecoder().decode(type.self, from: data) {
            return onCompletion(.success(response))
        } else {
            return onCompletion(.failure(.DecodingError))
        }
    }
}
