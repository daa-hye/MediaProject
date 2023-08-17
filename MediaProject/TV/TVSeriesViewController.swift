//
//  TVSeriesViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/17.
//

import UIKit

class TVSeriesViewController: UIViewController {

    @IBOutlet var TVSeriesCollectionView: UICollectionView!

    var seasonsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func getSeasonsCount(id: Int) {
        TVAPIManager.shared.request(id: id) { count in
            self.seasonsCount = count
        }
    }

}

extension TVSeriesViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seasonsCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        <#code#>
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
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)

        TVSeriesCollectionView.collectionViewLayout = layout
    }
}
