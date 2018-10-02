//
//  Mock.swift
//  ReduxMovieDBEarlTests
//
//  Created by Bakhtiozin Andrii on 9/19/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation
@testable import ReduxMovieDB

class Mock: TMDBFetcherMockApi {
    override func fetchMovieGenres(completion: @escaping (GenreList?) -> Void) {
        completion(
            GenreList(genres: [
                Genre(id: 1, name: "Action"),
                Genre(id: 2, name: "Drama")
                ])
        )
    }

    override func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        completion(TMDBPagedResult(results: [
            Movie(id: 0, title: "The Matrix", releaseDate: "2018-09-15", posterPath: "path", genreIds: [1, 2], overview: "No"),
            Movie(id: 1, title: "To the Moon", releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes"),
            Movie(id: 0, title: "Zorggg", releaseDate: "2018-09-11", posterPath: "path", genreIds: [1, 2], overview: "No"),
            Movie(id: 0, title: "Skyhigh", releaseDate: "2018-09-12", posterPath: "path", genreIds: [1, 2], overview: "No")
            ], page: 1, totalPages: 1, totalResults: 2))
    }

    override func searchMovies(query: String, page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        switch query {
        case "The ":
            completion(TMDBPagedResult(results: [
                Movie(id: 0, title: "The Matrix", releaseDate: "2018-09-15", posterPath: "path", genreIds: [1, 2], overview: "No"),
                Movie(id: 1, title: "The Matrix 3", releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes"),
                Movie(id: 2, title: "The Zombie", releaseDate: "2018-09-20", posterPath: "path", genreIds: [2], overview: "Zzzzoombie")
                ], page: 1, totalPages: 1, totalResults: 3))
        case "The Matrix":
            completion(TMDBPagedResult(results: [
                Movie(id: 0, title: "The Matrix", releaseDate: "2018-09-15", posterPath: "path", genreIds: [1, 2], overview: "No"),
                Movie(id: 1, title: "The Matrix 3", releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes")
                ], page: 1, totalPages: 1, totalResults: 2))
        case "The Matrix 3":
            completion(TMDBPagedResult(results: [
                Movie(id: 1, title: "The Matrix 3", releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes")
                ], page: 1, totalPages: 1, totalResults: 2))
        default:
            completion(nil)
        }
    }
}
