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

        profileImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(100)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(30)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
}
