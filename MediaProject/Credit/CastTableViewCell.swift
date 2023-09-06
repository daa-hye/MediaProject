//
//  CastTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit

final class CastTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var characterTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameTextLabel.font = .systemFont(ofSize: 17)
        characterTextLabel.font = .systemFont(ofSize: 16)
        characterTextLabel.textColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
