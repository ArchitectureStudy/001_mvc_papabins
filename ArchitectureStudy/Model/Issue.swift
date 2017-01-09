//
//  Issue.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 6..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Issue: Mappable {
    
    var id: Double = 0
    var number: Double = 0
    var title: String? = ""
    var state: String? = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        number <- map["number"]
        title <- map["title"]
        state <- map["state"]
    }
}

/*
{
    "url": "https://api.github.com/repos/Alamofire/Alamofire/issues/1897",
    "repository_url": "https://api.github.com/repos/Alamofire/Alamofire",
    "labels_url": "https://api.github.com/repos/Alamofire/Alamofire/issues/1897/labels{/name}",
    "comments_url": "https://api.github.com/repos/Alamofire/Alamofire/issues/1897/comments",
    "events_url": "https://api.github.com/repos/Alamofire/Alamofire/issues/1897/events",
    "html_url": "https://github.com/Alamofire/Alamofire/issues/1897",
    "id": 199360648,
    "number": 1897,
    "title": "Getting data but result is failure",
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
    },
    "labels": [
    
    ],
    "state": "open",
    "locked": false,
    "assignee": null,
    "assignees": [
    
    ],
    "milestone": null,
    "comments": 0,
    "created_at": "2017-01-07T13:03:17Z",
    "updated_at": "2017-01-07T13:03:17Z",
    "closed_at": null,
    "body": "FAILURE: responseSerializationFailed(Alamofire.AFError.ResponseSerializationFailureReason.jsonSerializationFailed(Error Domain=NSCocoaErrorDomain Code=3840 \"Invalid value around character 0.\" UserInfo={NSDebugDescription=Invalid value around character 0.}))\r\n  ▿ failure : AFError\r\n    ▿ responseSerializationFailed : ResponseSerializationFailureReason"
}

*/

