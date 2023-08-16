//
//  URL + Extension.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import Foundation

extension URL {

    static let tmdbURL = "https://api.themoviedb.org/3/"
    static let imageURL = "https://image.tmdb.org/t/p/w500"

    static func makeTmdbEndPointString(_ endPoint: String) -> String {
        return tmdbURL + endPoint
    }

    static func makeImageURL(_ endPoint: String) -> URL? {
        return URL(string: imageURL + endPoint)
    }
}
