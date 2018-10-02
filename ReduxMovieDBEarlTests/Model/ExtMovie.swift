//
//  ExtMovie.swift
//  ReduxMovieDBEarlTests
//
//  Created by Bakhtiozin Andrii on 9/17/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation
@testable import ReduxMovieDB

class ExtMovie {
    let movie: Movie
    let genre: String
    init(movie: Movie, genre: String) {
        self.movie = movie
        self.genre = genre
    }
}
