//
//  BaseView.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/28.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() { }

    func setConstraints() { }

}