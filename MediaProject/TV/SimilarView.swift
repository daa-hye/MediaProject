//
//  SimilarView.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/09/02.
//

import UIKit
import WebKit

class SimilarView: BaseView {

    let similarSegControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [Segment.video.segTitle, Segment.similar.segTitle])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
      }()
    
    lazy var stilCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(TVSeriesCollectionViewCell.self, forCellWithReuseIdentifier: TVSeriesCollectionViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        addSubview(similarSegControl)
        addSubview(stilCollectionView)

        configureSeg()

    }

    override func setConstraints() {

        similarSegControl.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        stilCollectionView.snp.makeConstraints {
            $0.top.equalTo(similarSegControl.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

extension SimilarView {

    private func configureSeg() {
        similarSegControl.selectedSegmentIndex = 0
    }

    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical

        return layout
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
