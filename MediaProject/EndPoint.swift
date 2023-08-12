//
//  EndPoint.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import Foundation

enum EndPoint {
    case trending
    case credits

    var url: String {
        switch self {
        case .trending:
            return URL.makeTmdbEndPointString("trending/movie/day")
        case .credits:
            return URL.makeTmdbEndPointString("movie/")
        }
    }
}
