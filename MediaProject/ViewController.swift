//
//  ViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var movieListTableView: UITableView!

    var movieList: [Movie] = []
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "최신 영화"

        movieListTableView.delegate = self
        movieListTableView.dataSource = self

        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        movieListTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)

        movieListTableView.rowHeight = 400

        getMovieList(page)
    }

    func getMovieList(_ page: Int) {

        MovieAPIManager.shared.callRequest(page: page) { movieJson in
            let results = movieJson["results"].arrayValue

            for item in results {
                let id = item["id"].intValue
                let title = item["title"].stringValue
                let releaseDate = item["release_date"].stringValue
                let rating = item["vote_average"].doubleValue
                let posterPath = item["poster_path"].stringValue
                let backDropPath = item["backdrop_path"].stringValue

                let movie = Movie(id: id, title: title, releaseDate: releaseDate, rating: rating, posterPath: posterPath, backDropPath: backDropPath)
                self.movieList.append(movie)
            }
            self.movieListTableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }
        cell.titleTextLabel.text = movieList[indexPath.row].title

        if let url = URL.makeImageURL(movieList[indexPath.row].posterPath) {
            cell.posterImageView.kf.setImage(with: url)
        }

        cell.ratingTextView.text = String(format: "평점 ★ %.1f점", movieList[indexPath.row].rating)
        cell.releaseDateTextView.text = movieList[indexPath.row].releaseDate
        return cell
    }


}

