//
//  LoginPresenter.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 2. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    var model: GithubInfo
    
    required init() {
        
        self.model = GithubInfo.sharedInstance
    }
    
    public func setUserName(userName: String?) {
        self.model.userName = userName
    }
    
    public func setRepository(repository: String?) {
        self.model.repository = repository
    }
    
    public func setAccessToken(accessToken: String?) {
        self.model.accessToken = accessToken
    }
    
}
