//
//  SimilarView.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/09/02.
//

import UIKit
import WebKit

class SimilarView: BaseView {

    let similarSegControl = UISegmentedControl()
    let stilCollectionView = UICollectionView()

    var videoThumbnail:[String] = []
    var similarPosters:[String] = []
    
    override func configureView() {
        addSubview(similarSegControl)
        addSubview(stilCollectionView)

        configureCollectionViewLayout()
        configureSeg()

        //similarSegControl.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
    }

    override func setConstraints() {

        similarSegControl.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        stilCollectionView.snp.makeConstraints {
            $0.top.equalTo(similarSegControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
}

extension SimilarView {

    @objc private func segValueChanged() {
        stilCollectionView.reloadData()
    }

    private func configureSeg() {
        similarSegControl.setTitle(Segment.video.segTitle, forSegmentAt: Segment.video.rawValue)
        similarSegControl.setTitle(Segment.similar.segTitle, forSegmentAt: Segment.similar.rawValue)
    }

    private func configureCollectionViewLayout() {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 480, height: 360)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical

        stilCollectionView.collectionViewLayout = layout
    }
    
}

enum Segment: Int {
    case video
    case similar

    var segTitle: String {
        switch self {
        case .video:
            return "영상"
        case .similar:
            return "비슷한 시리즈"
        }
    }
}
