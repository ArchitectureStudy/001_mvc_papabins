//
//  User.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper

class User: Mappable {
    var id: Double = 0
    var login: String? = ""
    var avatarUrl: String? = nil
    var url: String? = ""
    
    init() {}
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
        avatarUrl <- map["avatar_url"]
        url <- map["url"]
    }
}











































/*
"user": {
    "login": "jeffayan",
    "id": 17008251,
    "avatar_url": "https://avatars.githubusercontent.com/u/17008251?v=3",
    "gravatar_id": "",
    "url": "https://api.github.com/users/jeffayan",
    "html_url": "https://github.com/jeffayan",
    "followers_url": "https://api.github.com/users/jeffayan/followers",
    "following_url": "https://api.github.com/users/jeffayan/following{/other_user}",
    "gists_url": "https://api.github.com/users/jeffayan/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/jeffayan/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/jeffayan/subscriptions",
    "organizations_url": "https://api.github.com/users/jeffayan/orgs",
    "repos_url": "https://api.github.com/users/jeffayan/repos",
    "events_url": "https://api.github.com/users/jeffayan/events{/privacy}",
    "received_events_url": "https://api.github.com/users/jeffayan/received_events",
    "type": "User",
    "site_admin": false
}
*/
