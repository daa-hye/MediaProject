//
//  OverViewTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {

    @IBOutlet var contentTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentTextLabel.textAlignment = .left
        contentTextLabel.font = .systemFont(ofSize: 15)
        contentTextLabel.numberOfLines = 0
    }

}
