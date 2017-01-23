//
//  APIManager.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 22..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: APIManagerProtocol {
    
    static let sharedInstance : APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    private var manager: APIManagerProtocol
    
    private init() {
        self.manager = SessionManager.default
    }
    
}
