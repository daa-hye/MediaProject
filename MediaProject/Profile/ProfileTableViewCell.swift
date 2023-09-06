//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

final class ProfileTableViewCell: BaseTableViewCell {

    let label = {
        let view = UILabel()
        view.textAlignment = .left
        return view
    }()

    let sublabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .lightGray
        return view
    }()

    override func configureView() {
        contentView.addSubview(label)
        contentView.addSubview(sublabel)
    }

    override func setConstraints() {

        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }

        sublabel.snp.makeConstraints {
            $0.leading.equalTo(label.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }

    }
}
