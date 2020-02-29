//
//  Wired_ReaderTests.swift
//  Wired ReaderTests
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import XCTest
@testable import Wired_Reader

class Wired_ReaderTests: XCTestCase {

    func testFeedLoading() {
        let expectations = expectation(description: "Feed")

        Feed.loadRSS { (result) in

            switch result {

            case .failure:
                break

            case .success:
                expectations.fulfill()
            }
        }

        wait(for: [expectations], timeout: 5)
    }
}
