//
//  Feed.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import Foundation

class Feed: NetworkClient {

    static func loadRSS(_ completion: @escaping ((Result<Bool, Error>) -> Void)) {
        let request = Request(kind: .rss).buildURLRequest()

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                process(data)
                completion(.success(true))
            }
        }
        dataTask.resume()
    }

    private static func process(_ data: Data) {
        let parser = Parser(data: data)
        parser.parse()
    }
}
