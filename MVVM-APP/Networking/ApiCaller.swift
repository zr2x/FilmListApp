//
//  ApiCaller.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

class ApiCaller {
    
    static func getTrendingMovies(completionHandler: @escaping(_ result: Result<TrendingMovieModel, NetworkError>) -> Void) {
        
        let urlString = NetworkConstant.shared.serverAddress + "trending/all/day?api_key=" + NetworkConstant.shared.apiKey
        
        guard let url = URL(string: urlString) else { return completionHandler(.failure(.urlError))}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { dataResponse, response, error in
            if let data = dataResponse,
               error == nil,
                let result = try? JSONDecoder().decode(TrendingMovieModel.self, from: data) {
                completionHandler(.success(result))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
