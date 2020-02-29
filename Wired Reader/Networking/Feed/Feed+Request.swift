//
//  Feed+Request.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import Foundation

extension Feed {

    class Request: NetworkRequest {

        enum Kind {
            case rss
        }

        override var method: String {
            switch kind {
            case .rss:
                return "GET"
            }
        }

        override var path: String {
            switch kind {
            case .rss:
                return "/feed/rss"
            }
        }

        override var parameters: [String : Any]? {
            switch kind {
            case .rss:
                return nil
            }
        }


        // MARK: - Init

        public var kind: Kind

        public init(kind: Kind) {
          self.kind = kind
        }
    }
}
