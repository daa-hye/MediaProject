//
//  TVAPIManager.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/17.
//

import Foundation
import Alamofire

class TVAPIManager {

    static let shared = TVAPIManager()

    private init() { }

    func request(id: Int, completionHandler: @escaping (Int) -> Void) {

        let url = "https://api.themoviedb.org/3/tv/\(id)?api_key=\(APIKey.tmdb)"

        AF.request(url, method: .get).validate().responseDecodable(of: TVSeriesData.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value.numberOfSeasons)
            case .failure(let error):
                print(error)
            }
        })
    }

    func request(id: Int, season: Int, completionHandler: @escaping ([Episode]?) -> Void) {

        let url = "https://api.themoviedb.org/3/tv/\(id)/season/\(season)?api_key=\(APIKey.tmdb)"

        AF.request(url, method: .get).validate().responseDecodable(of: TVSeasonsData.self, completionHandler: { response in
            switch response.result {
            case .success(let value):89
                completionHandler(value.episodes ?? nil)
            case .failure(let error):
                print(error)
            }
        })

    }

    func requestSimilar(id: Int, completionHandler: @escaping ([String]) -> Void) {

        let url = "https://api.themoviedb.org/3/tv/\(id)/similar?api_key=\(APIKey.tmdb)"
        var posters: [String] = []

        AF.request(url, method: .get).validate().responseDecodable(of: TVSimilarData.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                let results = value.results
                for item in results {
                    posters.append(item.posterPath ?? "")
                }
                completionHandler(posters)
            case .failure(let error):
                print(error)
            }
        })
    }

    func requestVideo(id: Int, completionHandler: @escaping ([String]) -> Void) {

        let url = "https://api.themoviedb.org/3/tv/\(id)/videos?api_key=\(APIKey.tmdb)"
        var thumbnails: [String] = []

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: VideoData.self, completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let results = value.results
                    for item in results {
                        if item.site == "YouTube" {
                            let url = "https://img.youtube.com/vi/\(item.key)/mqdefault.jpg"
                            thumbnails.append(url)
                        }
                    }
                    print("completion call")
                    completionHandler(thumbnails)
                case .failure(let error):
                    print(error)
                }
            })

        print("requestVideo ended")
    }

}
