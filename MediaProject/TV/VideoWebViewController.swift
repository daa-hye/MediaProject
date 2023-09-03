//
//  VideoWebViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/09/03.
//

import UIKit
import WebKit

class VideoWebViewController: BaseViewController {

    let webView = WKWebView()
    var link: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let link = self.link else { return }
        let request = URLRequest(url: link)
        webView.load(request)

    }

    override func configureView() {
        view.addSubview(webView)
    }

    override func setConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

}

extension VideoWebViewController: WKUIDelegate {

    func reloadButtonClicked() {
        webView.reload()
    }

    func goBakcButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    func doForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

}
