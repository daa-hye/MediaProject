//
//  CreditData.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/16.
//

import Foundation

// MARK: - CreditData
struct CreditData: Codable {
    let id: Int
    let crew, cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let castID: Int?
    let name: String
    let id: Int
    let knownForDepartment: String
    let popularity: Double
    let originalName: String
    let gender: Int
    let character: String?
    let profilePath: String?
    let creditID: String
    let adult: Bool
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case name, id
        case knownForDepartment = "known_for_department"
        case popularity
        case originalName = "original_name"
        case gender, character
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case adult, order, department, job
    }
}
