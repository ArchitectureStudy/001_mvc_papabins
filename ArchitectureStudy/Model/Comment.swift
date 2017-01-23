//
//  Comment.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper

class Comment: Mappable {
    var id: Double = 0
    var url: String? = ""
    var createdAt: String? = ""
    var body: String? = ""
    
    var user: User = User()
    
    init() {}
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        createdAt <- map["created_at"]
        body <- map["body"]
        user <- map["user"]
    }
}










































/*
{
    "url": "https://api.github.com/repos/ArchitectureStudy/study/issues/comments/274332026",
    "html_url": "https://github.com/ArchitectureStudy/study/issues/35#issuecomment-274332026",
    "issue_url": "https://api.github.com/repos/ArchitectureStudy/study/issues/35",
    "id": 274332026,
    "user": {
        "login": "lcg5450",
        "id": 2516297,
        "avatar_url": "https://avatars.githubusercontent.com/u/2516297?v=3",
        "gravatar_id": "",
        "url": "https://api.github.com/users/lcg5450",
        "html_url": "https://github.com/lcg5450",
        "followers_url": "https://api.github.com/users/lcg5450/followers",
        "following_url": "https://api.github.com/users/lcg5450/following{/other_user}",
        "gists_url": "https://api.github.com/users/lcg5450/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/lcg5450/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/lcg5450/subscriptions",
        "organizations_url": "https://api.github.com/users/lcg5450/orgs",
        "repos_url": "https://api.github.com/users/lcg5450/repos",
        "events_url": "https://api.github.com/users/lcg5450/events{/privacy}",
        "received_events_url": "https://api.github.com/users/lcg5450/received_events",
        "type": "User",
        "site_admin": false
    },
    "created_at": "2017-01-22T13:49:24Z",
    "updated_at": "2017-01-22T13:49:24Z",
    "body": "aadffsf"
}
*/
