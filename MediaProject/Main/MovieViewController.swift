//
//  MovieViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit
import Kingfisher

class MovieViewController: BaseViewController {

    private let mainView = MovieView()

    private var movieList: [Movie] = []
    private var page = 1

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieList(page)
    }

    override func configureView() {
        super.configureView()

        title = "최신 영화"
        mainView.movieListTableView.delegate = self
        mainView.movieListTableView.dataSource = self
    }

    override func setConstraints() {
        mainView.movieListTableView.rowHeight = 400
    }

    private func getMovieList(_ page: Int) {

        MovieAPIManager.shared.callRequest(page: page) { trendingData in
            for item in trendingData.results {
                let movie = Movie(id: item.id, title: item.title, originalTitle: item.originalTitle, releaseDate: item.releaseDate, rating: item.voteAverage, overview: item.overview, posterPath: item.posterPath, backDropPath: item.backdropPath)
                self.movieList.append(movie)
            }
            self.mainView.movieListTableView.reloadData()
        }
    }

}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movieList[indexPath.row]

        cell.titleTextLabel.text = movie.title
        cell.originalTitleLabel.text = movie.originalTitle

        if let url = URL.makeImageURL(movie.posterPath) {
            cell.posterImageView.kf.setImage(with: url)
        }

        cell.ratingTextView.text = String(format: "평점 ★ %.1f점", movie.rating)
        cell.releaseDateTextView.text = movie.releaseDate
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }

        vc.movie = movieList[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}

