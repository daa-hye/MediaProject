//
//  TVSeriesViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/17.
//

import UIKit
import Kingfisher

class TVSeriesViewController: UIViewController {

    @IBOutlet var TVSeriesCollectionView: UICollectionView!

    var seasonsCount = 0
    var stils: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()

        getSeasonsCount(id: 42009)

    }

    func getSeasonsCount(id: Int) {

        TVAPIManager.shared.request(id: id) { count in
            self.seasonsCount = count

            for i in 0..<count {
                self.getSeasonsData(id: id, season: i)
            }
        }
    }

    func getSeasonsData(id: Int, season: Int) {

        var stilcut: [String] = []

        TVAPIManager.shared.request(id: id, season: season) { episodes in
            guard let episodes = episodes else { return }
            for episode in episodes {
                stilcut.append(episode.stillPath)
            }
            self.stils.append(stilcut)
            self.TVSeriesCollectionView.reloadData()
        }
    }

}

extension TVSeriesViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seasonsCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stils.count < seasonsCount ? 0 :stils[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesCollectionViewCell.identifier, for: indexPath) as? TVSeriesCollectionViewCell else { return UICollectionViewCell() }
        let url = URL.makeImageURL(stils[indexPath.section][indexPath.row])
        cell.stillImageView.kf.setImage(with: url)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader, let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TVSeasonsCollectionReusableView.identifier, for: indexPath) as? TVSeasonsCollectionReusableView else { return UICollectionReusableView() }

        view.seasonLabel.text = "시즌 \(indexPath.section + 1)"

        return view
    }


}

extension TVSeriesViewController {

    func configureCollectionView() {
        TVSeriesCollectionView.delegate = self
        TVSeriesCollectionView.dataSource = self
        TVSeriesCollectionView.register(UINib(nibName: TVSeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:TVSeriesCollectionViewCell.identifier)
        TVSeriesCollectionView.register(UINib(nibName: TVSeasonsCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVSeasonsCollectionReusableView.identifier)
    }

    func configureCollectionViewLayout() {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 30)

        TVSeriesCollectionView.collectionViewLayout = layout
    }
}
