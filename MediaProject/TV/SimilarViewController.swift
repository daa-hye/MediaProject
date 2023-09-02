//
//  SimilarViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/18.
//

import UIKit

class SimilarViewController: BaseViewController {

    private var videoThumbnail:[String] = []
    private var similarPosters:[String] = []

    private let mainView = SimilarView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        group.enter()
        getVideoThumbnail(id: 95479)
        group.enter()
        getSimilar(id: 95479)

        group.notify(queue: .main) {
            //mainView.similarPosters = similarPosters
        }
    }

    override func configureView() {
        super.configureView()

        mainView.stilCollectionView.delegate = self
        mainView.stilCollectionView.dataSource = self
    }

    private let group = DispatchGroup()

    private func getVideoThumbnail(id: Int) {
        TVAPIManager.shared.requestVideo(id: id) { url in
            self.videoThumbnail = url
            self.group.leave()
        }
    }

    private func getSimilar(id: Int) {
        TVAPIManager.shared.requestSimilar(id: id) { posters in
            self.similarPosters = posters
            self.group.leave()
        }
    }

}

extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if mainView.similarSegControl.selectedSegmentIndex == Segment.video.rawValue {
            return videoThumbnail.count
        } else if mainView.similarSegControl.selectedSegmentIndex == Segment.similar.rawValue {
            return similarPosters.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesCollectionViewCell.identifier, for: indexPath) as? TVSeriesCollectionViewCell else { return UICollectionViewCell() }

        if mainView.similarSegControl.selectedSegmentIndex == Segment.video.rawValue {
            cell.stillImageView.kf.setImage(with: URL(string: videoThumbnail[indexPath.row]))
        } else if mainView.similarSegControl.selectedSegmentIndex == Segment.similar.rawValue {
            let url = URL.makeImageURL(similarPosters[indexPath.row])
            cell.stillImageView.kf.setImage(with: url)
        } else { return UICollectionViewCell() }

        return cell
    }

}
