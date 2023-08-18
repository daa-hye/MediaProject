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

    var videoThumbnail:[String] = []
    var similarPosters:[String] = []

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

    let group = DispatchGroup()

    func getVideoThumbnail(id: Int) {
        TVAPIManager.shared.requestVideo(id: id) { url in
            self.videoThumbnail = url
            self.group.leave()
        }
    }

    func getSimilar(id: Int) {
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
        } else {
            return 0
        }

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

    func configureSeg() {
        similarSegControl.setTitle(Segment.video.segTitle, forSegmentAt: Segment.video.rawValue)
        similarSegControl.setTitle(Segment.similar.segTitle, forSegmentAt: Segment.similar.rawValue)
    }

    func configureCollectionView() {
        stilCollectionView.delegate = self
        stilCollectionView.dataSource = self
        stilCollectionView.register(UINib(nibName: TVSeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:TVSeriesCollectionViewCell.identifier)
    }

    func configureCollectionViewLayout() {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 480, height: 360)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical

        stilCollectionView.collectionViewLayout = layout
    }
}
