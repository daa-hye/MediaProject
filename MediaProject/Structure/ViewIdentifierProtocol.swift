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

extension MovieDetailViewController: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension CastTableViewCell: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension OverViewTableViewCell: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension CrewTableViewCell: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension TVSeriesViewController: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension TVSeriesCollectionViewCell: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension TVSeasonsCollectionReusableView: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}
