//
//  CrewTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit

class CrewTableViewCell: UITableViewCell {

    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var jobTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameTextLabel.font = .systemFont(ofSize: 15)
        jobTextLabel.font = .systemFont(ofSize: 14)
        jobTextLabel.textColor = .gray
    }

}
