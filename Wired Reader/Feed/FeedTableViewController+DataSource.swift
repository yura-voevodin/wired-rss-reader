//
//  FeedTableViewController+DataSource.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import UIKit

extension FeedTableViewController {

    class DataSource {

        var items: [Feed.Item] = []

        func loadItems(_ completion: @escaping (() -> Void)) {
            Feed.loadRSS { [weak self] (result) in
                DispatchQueue.main.async {
                    self?.process(result)
                    completion()
                }
            }
        }

        private func process(_ result: Result<[Feed.Item], Error>) {
            switch result {
            case .failure:
                items = []
            case .success(let items):
                self.items = items
            }
        }
    }
}
