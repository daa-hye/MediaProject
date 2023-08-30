//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

class ProfileViewController: BaseViewController {

    let mainview = ProfileView()
    let setting = ["이름", "사용자 이름", "성별", "소개", "링크"]

    override func loadView() {
        self.view = mainview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "프로필 편집"
    }

    override func configureView() {
        super.configureView()

        mainview.tableView.delegate = self
        mainview.tableView.dataSource = self
    }

    override func setConstraints() {
        super.setConstraints()
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setting.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as? ProfileTableViewCell else { return UITableViewCell() }
        cell.label.text = setting[indexPath.row]
        cell.sublabel.text = setting[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.title = setting[indexPath.row]
        vc.profileTextField.placeholder = setting[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
