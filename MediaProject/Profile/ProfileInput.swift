//
//  ProfileInput.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/30.
//

import UIKit

class ProfileInput: BaseView {

    let stack = {
        let view = UIStackView()
        view.distribution = .fill
        return view
    }()

    var label = {
        let view = UILabel()
        view.textAlignment = .left
        return view
    }()

    var textFiled = UITextField()

    override func configureView() {
        stack.addSubview(label)
        stack.addSubview(textFiled)
        addSubview(stack)
    }

    override func setConstraints() {
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
    }
}
