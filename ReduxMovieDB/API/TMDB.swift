//
//  TMDB.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Foundation

struct TMDBPagedResult<T: Codable>: Codable {
    let results: [T]
    let page: Int
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

protocol TMDBFetcher {
    func fetchMovieGenres(completion: @escaping (GenreList?) -> Void)
    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void)
    func searchMovies(query: String, page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void)
}

class TMDB: TMDBFetcher {
    static let shared = TMDB()
    var api: TMDBFetcher?

    private init() {}

    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        api?.fetchUpcomingMovies(page: page, completion: completion)
    }

    func fetchMovieGenres(completion: @escaping (GenreList?) -> Void) {
        api?.fetchMovieGenres(completion: completion)
    }

    func searchMovies(query: String, page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        api?.searchMovies(query: query, page: page, completion: completion)
    }
}

class TMDBFetcherMockApi : TMDBFetcher {

    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        completion(nil)
    }

    func fetchMovieGenres(completion: @escaping (GenreList?) -> Void) {
        completion(nil)
    }

    func searchMovies(query: String, page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        completion(nil)
    }
}

class TMDBFetcherApi : TMDBFetcher {
    let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    let baseUrl = "https://api.themoviedb.org/3"

    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        fetch(
            url: "\(baseUrl)/movie/upcoming?api_key=\(apiKey)&language=en-US&page=\(page)",
            completion: completion
        )
    }

    func fetchMovieGenres(completion: @escaping (GenreList?) -> Void) {
        fetch(
            url: "\(baseUrl)/genre/movie/list?api_key=\(apiKey)",
            completion: completion
        )
    }

    func searchMovies(query: String, page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        fetch(
            url: "\(baseUrl)/search/movie?api_key=\(apiKey)&language=en-US&query=\(query)&page=\(page)",
            completion: completion
        )
    }

    func fetch<T: Codable>(url: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return completion(nil) }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data = data,
                let obj = try? JSONDecoder().decode(T.self, from: data)
                else {
                    return completion(nil)
            }
            completion(obj)
        }
        task.resume()
    }
}
