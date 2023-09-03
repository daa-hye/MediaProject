//
//  TVSeriesCollectionViewCell.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/17.
//

import UIKit

class TVSeriesCollectionViewCell: BaseCollectionViewCell {
    
    let stillImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func configureView() {
        addSubview(stillImageView)
    }

    override func setConstraints() {
        stillImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
