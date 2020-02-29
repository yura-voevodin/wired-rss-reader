//
//  NibLoadableView.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }
}
