//
//  Feed+Parser.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import Foundation

extension Feed {

    class Parser: NSObject {

        // MARK: - Properties

        private var parser: XMLParser

        /// Array of parser items
        var items: [Item] = []

        /// For parse the current item
        private var currentKey: Item.Key? = nil

        // Arrays of parsed data
        private var parsedData: [[Item.Key: String]] = []
        private var currentData: [Item.Key: String] = [:]

        // MARK: - Init

        init(data: Data) {
            parser = XMLParser(data: data)
        }

        // MARK: - Parse

        func parse() -> [Item] {
            parser.delegate = self
            parser.parse()

            let items = parsedData.compactMap { (data) in
                return Item(data: data)
            }
            return items
        }
    }
}

// MARK: - XMLParserDelegate

extension Feed.Parser: XMLParserDelegate {

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }

    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print(validationError)
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard let key = Feed.Item.Key(rawValue: elementName) else { return }
        currentKey = key

        // URL for thumbnail
        if key == .thumbnail {
            currentData[key] = attributeDict["url"]
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let key = currentKey else { return }
        switch key {

        case .description, .link, .title:
            let value = string.trimmingCharacters(in: .whitespaces)
            if !value.isEmpty {
                if let previousData = currentData[key] {
                    currentData[key] = previousData + value
                } else {
                    currentData[key] = value
                }
            }

        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard let key = currentKey else { return }
        if key == .thumbnail {
            // `thumbnail` is the last element in the item
            parsedData.append(currentData)
            currentData = [:]
            currentKey = nil
        }
    }
}
