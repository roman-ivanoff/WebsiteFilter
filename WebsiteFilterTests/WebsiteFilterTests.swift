//
//  WebsiteFilterTests.swift
//  WebsiteFilterTests
//
//  Created by Roman Ivanov on 18.11.2022.
//

import XCTest
@testable import WebsiteFilter

final class WebsiteFilterTests: XCTestCase {

    var sut: LinkModel!

    override func setUp() {
        sut = LinkModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testStringContainsUrl() {
        XCTAssertTrue(sut.containsURL(string: "google.com"))
    }

    func testStringDoesNotContainsUrl() {
        XCTAssertFalse(sut.containsURL(string: "cat and dog"))
    }

    func testStringContainsAtLeastTwoCharacters() {
        XCTAssertTrue(sut.containsAtLeastTwoCharacters("cat and dog"))
    }

    func testStringDoesNotContainsAtLeastTwoCharacters() {
        XCTAssertFalse(sut.containsAtLeastTwoCharacters("1"))
    }

    func testStringContainsSpace() {
        XCTAssertTrue(sut.containsSpace("cat and dog"))
    }

    func testStringDoesNotContainsSpace() {
        XCTAssertFalse(sut.containsSpace("google.com"))
    }

    func testStringStartsWithHttps() {
        XCTAssertTrue(sut.startsWithHttps("https://google.com"))
    }

    func testStringDoesNotStartsWithHttps() {
        XCTAssertFalse(sut.startsWithHttps("google.com"))
    }

    func testAddHttpsToString() {
        XCTAssertEqual("https://google.com", sut.addHttpsToString("google.com"))
    }
}
