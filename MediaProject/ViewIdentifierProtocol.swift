//
//  ViewIdentifierProtocol.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import Foundation

protocol ViewIdentifierProtocol {
    static var identifier: String { get }
}

extension MovieTableViewCell: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}
