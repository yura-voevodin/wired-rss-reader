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

        func loadItems(_ completion: @escaping ((_ error: Error?) -> Void)) {
            Feed.loadRSS { [weak self] (result) in
                DispatchQueue.main.async {
                    self?.process(result, completion)
                }
            }
        }

        private func process(_ result: Result<[Feed.Item], Error>, _ completion: @escaping ((_ error: Error?) -> Void)) {
            switch result {

            case .failure(let error):
                items = []
                completion(error)

            case .success(let items):
                self.items = items
                completion(nil)
            }
        }
    }
}
