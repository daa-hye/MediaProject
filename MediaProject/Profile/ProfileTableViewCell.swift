//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {

    let label = {
        let view = UILabel()
        view.textAlignment = .left
        return view
    }()

    let sublabel = {
        let view = UILabel()
        view.textAlignment = .left
        return view
    }()

    override func configureView() {
        contentView.addSubview(label)
        contentView.addSubview(sublabel)
    }

    override func setConstraints() {

        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }

        sublabel.snp.makeConstraints { make in
            make.left.equalTo(label.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
