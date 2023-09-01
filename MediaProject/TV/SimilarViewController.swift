//
//  SimilarViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/18.
//

import UIKit

class SimilarViewController: UIViewController {

    @IBOutlet var similarSegControl: UISegmentedControl!
    @IBOutlet var stilCollectionView: UICollectionView!

    private enum Segment: Int {
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

    private var videoThumbnail:[String] = []
    private var similarPosters:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSeg()
        configureCollectionView()
        configureCollectionViewLayout()

        group.enter()
        getVideoThumbnail(id: 95479)
        group.enter()
        getSimilar(id: 95479)

        group.notify(queue: .main) {
            self.stilCollectionView.reloadData()
        }

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

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        stilCollectionView.reloadData()
    }
    

}


extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if similarSegControl.selectedSegmentIndex == Segment.video.rawValue {
            return videoThumbnail.count
        } else if similarSegControl.selectedSegmentIndex == Segment.similar.rawValue {
            return similarPosters.count
        }

        return 0

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesCollectionViewCell.identifier, for: indexPath) as? TVSeriesCollectionViewCell else { return UICollectionViewCell() }

        if similarSegControl.selectedSegmentIndex == Segment.video.rawValue {
            cell.stillImageView.kf.setImage(with: URL(string: videoThumbnail[indexPath.row]))
        } else if similarSegControl.selectedSegmentIndex == Segment.similar.rawValue {
            let url = URL.makeImageURL(similarPosters[indexPath.row])
            cell.stillImageView.kf.setImage(with: url)
        } else { return UICollectionViewCell() }

        return cell
    }

    
}

extension SimilarViewController {

    private func configureSeg() {
        similarSegControl.setTitle(Segment.video.segTitle, forSegmentAt: Segment.video.rawValue)
        similarSegControl.setTitle(Segment.similar.segTitle, forSegmentAt: Segment.similar.rawValue)
    }

    private func configureCollectionView() {
        stilCollectionView.delegate = self
        stilCollectionView.dataSource = self
        stilCollectionView.register(UINib(nibName: TVSeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:TVSeriesCollectionViewCell.identifier)
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
