//
//  GithubInfo.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 2. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation

class GithubInfo {
    
    static let sharedInstance: GithubInfo = GithubInfo()
    
    private init() { }
    
    var userName: String? {
        didSet {
        }
    }
    var repository: String? {
        didSet {
        }
    }
    var accessToken: String? {
        didSet {
        }
    }
    
}
