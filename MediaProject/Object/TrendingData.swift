//
//  TrendingData.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/14.
//

import Foundation

struct TrendingData: Codable {
    let page: Int
    let results: [Result]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Result: Codable {
    let title: String
    let voteAverage: Double
    let adult, video: Bool
    let popularity: Double
    let backdropPath, overview, originalTitle: String
    let genreIDS: [Int]
    let id, voteCount: Int
    let originalLanguage: OriginalLanguage
    let posterPath: String
    let mediaType: MediaType
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case title
        case voteAverage = "vote_average"
        case adult, video, popularity
        case backdropPath = "backdrop_path"
        case overview
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case id
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case hi = "hi"
    case yo = "yo"
    case zh = "zh"
}
