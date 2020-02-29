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

        // MARK: - Init

        init?(data: [Key: String]) {
            // Title
            guard let title = data[.title] else { return nil }
            self.title = title

            // Link
            guard let linkString = data[.link] else { return nil }
            guard let link = URL(string: linkString) else { return nil }
            self.link = link

             // Description
            guard let description = data[.description] else { return nil }
            self.description = description

            // Thumbnail
            guard let thumbnailString = data[.thumbnail] else { return nil }
            guard let thumbnail = URL(string: thumbnailString) else { return nil }
            self.thumbnail = thumbnail
        }
    }
}
