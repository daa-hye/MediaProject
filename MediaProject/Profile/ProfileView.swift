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
        return view
    }()

    override func configureView() {
        addSubview(profileImage)
        addSubview(tableView)
    }

    override func setConstraints() {

        profileImage.snp.makeConstraints { make in
            make.center.top.equalTo(self.safeAreaLayoutGuide)
            make.width.height.equalTo(50)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
}
