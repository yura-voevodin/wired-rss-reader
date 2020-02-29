//
//  FeedItemTableViewCell.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    // MARK: - Update

    func update(with item: Feed.Item) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.description
    }
}
