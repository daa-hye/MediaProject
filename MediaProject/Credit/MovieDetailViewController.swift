//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/12.
//

import UIKit
import Kingfisher

fileprivate enum tableViewSection: String, CaseIterable {
    case overview
    case cast
    case crew
}

class MovieDetailViewController: UIViewController {

    @IBOutlet var creditTableView: UITableView!
    @IBOutlet var movieTitleTextView: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var backDropImageView: UIImageView!

    fileprivate let sections = tableViewSection.allCases

    private var castList: [Casting] = []
    private var crewList: [Crew] = []

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        creditTableView.register(nib, forCellReuseIdentifier: CastTableViewCell.identifier)

        creditTableView.delegate = self
        creditTableView.dataSource = self

        setUI()
        getMovieDetail()
    }

    private func getMovieDetail() {
        guard let movieID = movie?.id else { return }
        MovieAPIManager.shared.callRequest(movieID: movieID) { creditData in
            let casting = creditData.cast
            let crews = creditData.crew
            for item in casting {

                let name = item.name
                let character = item.character ?? ""
                let profilePath = item.profilePath ?? ""

                let cast = Casting(name: name, character: character, profilePath: profilePath)
                self.castList.append(cast)
            }
            for item in crews {

                let name = item.name
                let department = item.department ?? ""
                let job = item.job ?? ""
                let crew = Crew(name: name, department: department, job: job)
                self.crewList.append(crew)
            }
            self.creditTableView.reloadData()
        }
    }

    private func setUI() {

        title = "출연/제작"

        creditTableView.rowHeight = 130
        creditTableView.allowsSelection = false

        guard let movie = movie else { return }

        if let url = URL.makeImageURL(movie.posterPath) {
            posterImageView.kf.setImage(with: url)
        }

        if let url = URL.makeImageURL(movie.backDropPath) {
            backDropImageView.kf.setImage(with: url)
        }

        movieTitleTextView.text = movie.title
        movieTitleTextView.textColor = .white
        movieTitleTextView.font = .boldSystemFont(ofSize: 30)
    }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sections[section].rawValue

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .overview:
            return 1
        case .cast:
            return castList.count
        case .crew:
            return crewList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch sections[indexPath.section] {

        case .overview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier) as? OverViewTableViewCell else { return UITableViewCell() }
            cell.contentTextLabel.text = movie?.overview
            return cell

        case .cast:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }

            cell.nameTextLabel.text = castList[indexPath.row].name
            cell.characterTextLabel.text = castList[indexPath.row].character
            if let url = URL.makeImageURL(castList[indexPath.row].profilePath) {
                cell.profileImageView.kf.setImage(with: url)
            } else {
                cell.profileImageView.image = UIImage(systemName: "person")
            }
            return cell

        case .crew:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CrewTableViewCell.identifier) as? CrewTableViewCell else { return UITableViewCell() }
            cell.nameTextLabel.text = crewList[indexPath.row].name
            cell.jobTextLabel.text = "\(crewList[indexPath.row].department) / \(crewList[indexPath.row].job)"
            return cell
        }
    }


}
