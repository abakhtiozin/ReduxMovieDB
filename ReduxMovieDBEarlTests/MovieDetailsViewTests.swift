//
//  MovieDetailsViewTests.swift
//  ReduxMovieDBEarlTests
//
//  Created by Bakhtiozin Andrii on 9/14/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import XCTest
import EarlGrey
@testable import ReduxMovieDB

class MovieDetailsViewTests: XCTestCase {

    let movieListView = MovieListView()
    let movieDetailsView = MovieDetailsView()

    override func setUp() {
        super.setUp()
        TMDB.shared.api = Mock()
        mainStore.dispatch(fetchMovieGenres)
    }

    override func tearDown() {
        super.tearDown()
        movieDetailsView.pressBack()
        movieListView.cleanResult()
    }

    func testFindMovieAndOpen2Genres() {
        let movieName = "The Matrix"
        let movie = Movie(
                id: 0, title: movieName, releaseDate: "2018-09-15", posterPath: "path", genreIds: [1, 2], overview: "No"
        )
        movieListView.search(movieName: movieName)
                .choose(positionInList: 0)
                .assert(extMovie: ExtMovie(movie: movie, genre: "Action, Drama"))
    }

    func testFindMovieByAndOpenByText2Genres() {
        let movieName = "The Matrix"
        let movie = Movie(
                id: 0, title: movieName + " 3", releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes"
        )
        movieListView.search(movieName: movieName)
                .chooseByText(movieName: movieName + " 3")
                .assert(extMovie: ExtMovie(movie: movie, genre: "Action"))
    }

    func testFindMovieAndOpen1Genre() {
        let movieName = "The Matrix 3"
        let movie = Movie(
                id: 0, title: movieName, releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes"
        )
        movieListView.search(movieName: movieName)
                .choose(positionInList: 0)
                .assert(extMovie: ExtMovie(movie: movie, genre: "Action"))
    }

    func testFindMovieAndChooseByText() {
        let movieName = "The Matrix 3"
        let movie = Movie(
                id: 0, title: movieName, releaseDate: "2018-09-20", posterPath: "path", genreIds: [1], overview: "Yes"
        )
        movieListView.search(movieName: movieName)
                .chooseByText(movieName: movieName)
                .assert(extMovie: ExtMovie(movie: movie, genre: "Action"))
    }
}
