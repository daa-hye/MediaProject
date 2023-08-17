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

        let url = "https://api.themoviedb.org/3/tv/\(id)"

        AF.request(url, method: .get).validate().responseDecodable(of: TVSeriesData.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.numberOfSeasons)
            case .failure(let error):
                print(error)
            }
        })
    }

    func request(id: Int, season: Int, completionHandler: @escaping ([Episode]) -> Void) {

        let url = "https://api.themoviedb.org/3/tv/\(id)/season/\(season)"

        AF.request(url, method: .get).validate().responseDecodable(of: TVSeasonsData.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                let episodes = value.episodes
                completionHandler(value.episodes)
            case .failure(let error):
                print(error)
            }
        })

    }
}
