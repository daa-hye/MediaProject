//
//  MovieTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var ratingTextView: UILabel!
    @IBOutlet var releaseDateTextView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backView.backgroundColor = .clear
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        titleTextLabel.font = .boldSystemFont(ofSize: 17)
        ratingTextView.font = .systemFont(ofSize: 15)
        releaseDateTextView.font = .systemFont(ofSize: 13)
        releaseDateTextView.textColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
