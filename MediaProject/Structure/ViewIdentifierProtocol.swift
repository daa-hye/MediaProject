//
//  ViewIdentifierProtocol.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit

protocol ViewIdentifierProtocol {
    static var identifier: String { get }
}

extension UIViewController: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ViewIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}
