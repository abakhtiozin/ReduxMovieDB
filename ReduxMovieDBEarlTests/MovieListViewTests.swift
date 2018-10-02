//
//  MovieListViewTests.swift
//  ReduxMovieDBEarlTests
//
//  Created by Bakhtiozin Andrii on 9/19/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation
import XCTest
@testable import ReduxMovieDB

class MovieListViewTests: XCTestCase {

    let movieListView = MovieListView()

    override func setUp() {
        super.setUp()
        TMDB.shared.api = Mock()
        mainStore.dispatch(fetchMovieGenres)
    }

    override func tearDown() {
        super.tearDown()
        movieListView.cleanResult()
    }

    func testResultListWithTwoMatchFilter() {
        let movieName = "The Matrix"
        let expectedResults = 2
        movieListView.search(movieName: movieName)
                .assertCountOfResults(results: expectedResults)
    }

    func testResultListWithOneMatchFilter() {
        let movieName = "The Matrix 3"
        let expectedResults = 1
        movieListView.search(movieName: movieName)
                .assertCountOfResults(results: expectedResults)
    }

    func testResultListWithoutFilter() {
        mainStore.dispatch(fetchMoviesPage)
        let expectedResults = 4
        movieListView.assertCountOfResults(results: expectedResults)
    }

    func testResultListWithNoAnyMatchFilter() {
        let movieName = "King"
        let expectedResults = 0
        movieListView.search(movieName: movieName)
                .assertCountOfResults(results: expectedResults)
    }

    func testResultListsByTextWithFilter() {
        let movieName = "The Matrix"
        movieListView.search(movieName: movieName)
                .assertResults(movieName)
    }
}
