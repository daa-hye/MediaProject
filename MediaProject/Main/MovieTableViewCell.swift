//
//  MovieTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit

final class MovieTableViewCell: BaseTableViewCell {

    let backView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let titleTextLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()

    let originalTitleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()

    let ratingTextView = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        return view
    }()

    let releaseDateTextView = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .gray
        return view
    }()

    override func configureView() {
        contentView.addSubview(backView)
        backView.addSubview(posterImageView)
        backView.addSubview(titleTextLabel)
        backView.addSubview(originalTitleLabel)
        backView.addSubview(ratingTextView)
        backView.addSubview(releaseDateTextView)
    }

    override func setConstraints() {
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        posterImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        titleTextLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
        }
        originalTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextLabel)
            $0.leading.equalTo(titleTextLabel.snp.trailing).offset(8)
        }
        ratingTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextLabel.snp.bottom)
            $0.leading.equalTo(titleTextLabel)
        }
        releaseDateTextView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
}
