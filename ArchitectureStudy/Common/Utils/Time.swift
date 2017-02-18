//
//  Time.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 27..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation

struct Time {
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    static func date(_ string: String?) -> Date? {
        guard let string = string else { return nil }
        return Time.dateFormatter.date(from: string)
    }
}
