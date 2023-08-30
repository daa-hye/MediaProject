//
//  ProfileView.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

class ProfileView: BaseView {

    let profileImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        return view
    }()

    let tableView = {
        let view = UITableView()
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        view.separatorColor = .clear
        return view
    }()

    override func configureView() {
        addSubview(profileImage)
        addSubview(tableView)
    }

    override func setConstraints() {

        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.width.height.equalTo(100)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
}
