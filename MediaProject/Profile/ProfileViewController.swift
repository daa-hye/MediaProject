//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

protocol PassDataDelegate {
    func receiveDate(type: Setting, data: String)
}

enum Setting: Int, CaseIterable {
    case nickname
    case name
    case gender
    case introduce
    case link

    var title: String {
        switch self {
        case .nickname:
            return "이름"
        case .name:
            return "사용자 이름"
        case .gender:
            return "성별"
        case .introduce:
            return "소개"
        case .link:
            return "링크"
        }
    }

}

class ProfileViewController: BaseViewController {

    let mainview = ProfileView()
    var settingSubview = Setting.allCases.map{"\($0)"}

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
        return Setting.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as? ProfileTableViewCell else { return UITableViewCell() }
        cell.label.text = Setting(rawValue: indexPath.row)?.title
        cell.sublabel.text = settingSubview[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as? ProfileTableViewCell else { return }
        let vc = DetailViewController()
        vc.title = Setting(rawValue: indexPath.row)?.title
        vc.delegate = self
        vc.profileTextField.placeholder = settingSubview[indexPath.row]
        vc.type = Setting(rawValue: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}

extension ProfileViewController: PassDataDelegate {

    func receiveDate(type: Setting, data: String) {
        settingSubview[type.rawValue] = data
        mainview.tableView.reloadRows(at: [IndexPath(row: type.rawValue, section: 0)], with: .automatic)
    }

}
