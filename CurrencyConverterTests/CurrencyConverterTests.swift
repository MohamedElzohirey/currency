//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Mohamed Elzohirey on 01/08/2021.
//

import XCTest

class CurrencyConverterTests: XCTestCase {
    func test() throws {
        let codeChallange = CodeChallange()
        XCTAssertEqual(codeChallange.fibonacciRecursion(n: 10),codeChallange.fibonacciIteration(n: 10))
        XCTAssertEqual("debit card".isAnagramWith(secondString: "bad credit"), true)
        XCTAssertEqual("debitcardo".isAnagramWith(secondString: "bad credit"), false)
        XCTAssertEqual("punishments".isAnagramWith(secondString: "ninethumps"), true)
        XCTAssertEqual("punishments".isAnagramWith(secondString: "ninethums"), false)
    }

}
