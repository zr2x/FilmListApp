//
//  DetailMoviewViewModel.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 11.09.2023.
//

import Foundation

class DetailMovieViewModel {
    
    var movie: Movie
    
    var movieImage: URL?
    var movieTitle: String
    var movieDescription: String
    var movieId: Int
    
    init(movie: Movie) {
        self.movie = movie
        
        self.movieTitle = movie.name ?? movie.title ?? ""
        self.movieDescription = movie.overview
        self.movieId = movie.id
        self.movieImage = makeImageURL(movie.backdropPath)

    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageCode)")
    }
}
