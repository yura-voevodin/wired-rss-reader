//
//  WebController.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import WebKit
import UIKit

protocol WebControllerDelegate: class {
    func didLoadContent()
}

class WebController: UIViewController {

    // MARK: - Properties

    var url: URL?
    var webView: WKWebView!
    weak var delegate: WebControllerDelegate?

    // MARK: - Lifecycle

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = url {
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
    }
}

// MARK: - WKNavigationDelegate

extension WebController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegate?.didLoadContent()
    }
}

// MARK: - WKUIDelegate

extension WebController: WKUIDelegate {

}
