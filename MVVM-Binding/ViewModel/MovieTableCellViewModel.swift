//
//  MovieTableViewModel.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import Foundation

final class MovieTableCellViewModel {
    var id: Int
    var title: String
    var date: String
    var rating: String
    var imageUrl: URL?
    
    init(movie: MovieResult) {
        self.id = movie.id
        self.title = movie.title ?? movie.name ?? ""
        self.date = movie.releaseDate ?? movie.firstAirDate ?? ""
        self.rating = "\(movie.voteAverage)/10"
        self.imageUrl = makeImageURL(movie.posterPath)
    }
    
    private func makeImageURL( _ imageCode: String) -> URL? {
        URL(string: "\(Constants.imageServerAdress)\(imageCode)")
    }
}
