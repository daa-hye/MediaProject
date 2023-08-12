//
//  MovieAPIManager.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieAPIManager {

    static let shared = MovieAPIManager()

    private init() { }

    func callRequest(page: Int, completionHandler: @escaping (JSON) -> ()) {

        let query = "?query=page=\(page)&api_key=\(APIKey.tmdb)"
        let url = EndPoint.trending.url + query

        AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        completionHandler(json)
                    case .failure(let error):
                        print(error)
                    }
                }
    }

    func callRequest(movieID: Int, completionHandler: @escaping (JSON) -> ()) {

        let text = "\(movieID)/credits?api_key=\(APIKey.tmdb)"
        let url = EndPoint.credits.url + text

        AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        completionHandler(json)
                    case .failure(let error):
                        print(error)
                    }
                }
    }

}
