//
//  DetailViewModel.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 9.10.2023.
//

import Foundation

final class DetailViewModel {
    var movie: MovieResult
    
    var moviewImage: URL?
    var movieTitle: String
    var movieDescription: String
    var movieId: Int
    
    init(movie: MovieResult) {
        self.movie = movie
        
        self.movieId = movie.id
        self.movieDescription = movie.overview ?? ""
        self.movieTitle = movie.title ?? movie.name ?? ""
        self.moviewImage = makeImageURL(movie.backdropPath ?? "")
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(Constants.imageServerAdress)\(imageCode)")
    }
}
