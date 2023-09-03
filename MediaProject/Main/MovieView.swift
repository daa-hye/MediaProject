//
//  MovieView.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/28.
//

import UIKit

class MovieView: BaseView {

    let movieListTableView = {
        let view = UITableView()
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return view
    }()

    override func configureView() {
        addSubview(movieListTableView)
    }

    override func setConstraints() {
        movieListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
