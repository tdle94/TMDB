//
//  TMDBVideoPlayerViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SDWebImage

class TMDBVideoPlayerViewController: UIViewController {
    var url: URL?
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = url else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        view.sd_imageIndicator = SDWebImageActivityIndicator.gray
        view.sd_imageIndicator?.startAnimatingIndicator()
    }
}

extension TMDBVideoPlayerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.sd_imageIndicator?.stopAnimatingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        view.sd_imageIndicator?.stopAnimatingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        view.sd_imageIndicator?.stopAnimatingIndicator()
    }
}
