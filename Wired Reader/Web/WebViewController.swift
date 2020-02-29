//
//  WebViewController.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    // MARK: - Properties

    var url: URL?

    // MARK: - IBOutlets

    @IBOutlet weak var webContainerView: UIView!

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {

        case "webView":
            let vc = segue.destination as? WebController
            vc?.url = url
            vc?.delegate = self

        default:
            break
        }
    }
}

// MARK: - WebControllerDelegate

extension WebViewController: WebControllerDelegate {

    func didLoadContent() {
        
    }
}
