//
//  SimilarViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/18.
//

import UIKit

class SimilarViewController: BaseViewController {

    private var videoThumbnail: [String] = []
    private var videoURL: [String] = []
    private var similarPosters: [String] = []

    private let mainView = SimilarView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        group.enter()
        getVideoThumbnail(id: 66732)
        group.enter()
        getSimilar(id: 66732)

        group.notify(queue: .main) {
            self.mainView.stilCollectionView.reloadData()
        }
    }

    override func configureView() {
        super.configureView()

        mainView.stilCollectionView.delegate = self
        mainView.stilCollectionView.dataSource = self
        mainView.similarSegControl.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
    }

    @objc private func segValueChanged() {
        mainView.stilCollectionView.reloadData()
    }

    private let group = DispatchGroup()

    private func getVideoThumbnail(id: Int) {
        TVAPIManager.shared.requestVideo(id: id) { thumbnail, url in
            self.videoThumbnail = thumbnail
            self.videoURL = url
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
            cell.stillImageView.kf.setImage(with: URL(string: videoThumbnail[indexPath.item]))
        } else if mainView.similarSegControl.selectedSegmentIndex == Segment.similar.rawValue {
            let url = URL.makeImageURL(similarPosters[indexPath.item])
            cell.stillImageView.kf.setImage(with: url)
        } else { return UICollectionViewCell() }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard mainView.similarSegControl.selectedSegmentIndex == Segment.video.rawValue else {
            mainView.stilCollectionView.reloadItems(at: [indexPath])
            return
        }
        let vc = VideoWebViewController()
        vc.link = URL(string: videoURL[indexPath.item])
        present(vc, animated: true)
    }

}
