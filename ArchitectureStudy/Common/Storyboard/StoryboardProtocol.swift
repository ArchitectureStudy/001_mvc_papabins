//
//  StoryboardProtocol.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 3. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
