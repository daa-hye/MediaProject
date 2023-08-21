//
//  MovieAPIManager.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import Foundation
import Alamofire

class MovieAPIManager {

    static let shared = MovieAPIManager()

    private init() { }

    func callRequest(page: Int, completionHandler: @escaping (TrendingData) -> ()) {

        let query = "?query=page=\(page)&api_key=\(APIKey.tmdb)"
        let url = EndPoint.trending.url + query

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: TrendingData.self, completionHandler: { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            })

    }

    func callRequest(movieID: Int, completionHandler: @escaping (CreditData) -> ()) {

        let text = "\(movieID)/credits?api_key=\(APIKey.tmdb)"
        let url = EndPoint.credits.url + text

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: CreditData.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        })
    }

}
