//
//  LinkModel.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 16.11.2022.
//

import Foundation

// swiftlint:disable: force_try
class LinkModel {

    static func containsURL(string: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let match = detector.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count))

        return match?.range.length == string.utf16.count
    }
}
