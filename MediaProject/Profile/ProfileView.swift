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
        return view
    }()

    let nicknameStack = {
        let view = ProfileInput()
        view.label.text = "이름"
        view.textFiled.placeholder = "이름"
        return view
    }()

    let nameStack = {
        let view = ProfileInput()
        view.label.text = "이름"
        view.textFiled.placeholder = "이름"
        return view
    }()

    let genderStack = {
        let view = ProfileInput()
        view.label.text = "이름"
        view.textFiled.placeholder = "이름"
        return view
    }()

    let introduceStack = {
        let view = ProfileInput()
        view.label.text = "이름"
        view.textFiled.placeholder = "이름"
        return view
    }()

    let linkStack = {
        let view = ProfileInput()
        view.label.text = "이름"
        view.textFiled.placeholder = "이름"
        return view
    }()

    override func configureView() {
        addSubview(profileImage)
        addSubview(nicknameStack)
        addSubview(nameStack)
        addSubview(genderStack)
        addSubview(introduceStack)
        addSubview(linkStack)
    }

    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        nicknameStack.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(20)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(nicknameStack.snp.top)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
        genderStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.top)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
        introduceStack.snp.makeConstraints { make in
            make.top.equalTo(genderStack.snp.top)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
        linkStack.snp.makeConstraints { make in
            make.top.equalTo(introduceStack.snp.top)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
