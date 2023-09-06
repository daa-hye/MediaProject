//
//  DetailViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

final class DetailViewController: BaseViewController {

    weak var delegate: PassDataDelegate?
    var type: Setting?

    var completionHandler: ((Setting, String) -> Void)?

    let profileTextField = {
        let view = UITextField()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        guard let text = profileTextField.text else { return }
        //delegate!.receiveDate(type: type!, data: text)
        completionHandler?(type!, text)
    }

    override func configureView() {
        super.configureView()
        view.addSubview(profileTextField)
    }

    override func setConstraints() {
        profileTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
    
}
