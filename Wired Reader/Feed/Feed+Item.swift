//
//  Feed+Item.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import Foundation

extension Feed {

    /// Represents a single item in feed
    struct Item {

        // MARK: - Properties

        let title: String
        let link: URL
        let description: String
        let thumbnail: URL

        /// XML key
        enum Key: String {
            case title = "title"
            case link = "link"
            case guid = "guid"
            case pubDate = "pubDate"
            case mediaContent = "media:content"
            case description = "description"
            case category = "category"
            case keywords = "media:keywords"
            case creator = "dc:creator"
            case modified = "dc:modified"
            case publisher = "dc:publisher"
            case thumbnail = "media:thumbnail"
        }
    }
}
