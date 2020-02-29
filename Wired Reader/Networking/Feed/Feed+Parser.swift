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

        var items: [Item] = []
        private var currentItem: Item? = nil
        private var currentKey: Item.Key? = nil

        private var parsedData: [[String: String]] = []
        private var currentData: [String: String] = [:]

        // MARK: - Init

        init(data: Data) {
            parser = XMLParser(data: data)
        }

        // MARK: - Parse

        func parse() {
            parser.delegate = self
            parser.parse()

            parsedData.forEach { (data) in
                print("")
                print(data)
            }
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
            currentData[key.rawValue] = attributeDict["url"]
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let key = currentKey else { return }
        switch key {

        case .description, .link, .title:
            currentData[key.rawValue] = string

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
