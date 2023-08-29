//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

class ProfileViewController: BaseViewController {

    let mainview = ProfileView()

    override func loadView() {
        self.view = mainview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "프로필 편집"
    }

    override func configureView() {
        super.configureView()
    }

    override func setConstraints() {
        super.setConstraints()
    }

}
