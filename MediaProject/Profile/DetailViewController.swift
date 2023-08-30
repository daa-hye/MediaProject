//
//  DetailViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

class DetailViewController: BaseViewController {

    var delegate: PassDataDelegate?
    var type: Setting?

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
        delegate!.receiveDate(type: type!, data: text)
    }

    override func configureView() {
        super.configureView()
        view.addSubview(profileTextField)
    }

    override func setConstraints() {
        profileTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
    
}
