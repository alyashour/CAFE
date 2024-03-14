//
//  CAFETests.swift
//  CAFETests
//
//  Created by Aly Ashour on 2024-03-13.
//

import XCTest
@testable import CAFE

final class CAFETests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParse() {
        let parser = LineParser()
        // test all symbols with random whitespace
        let t1 = parser.parse("., = (")
        let t2 = parser.parse(") + - *")
        let t3 = parser.parse("/ ^ & ")
        
        
        XCTAssertEqual(t1, ["decimal:noVal", "decimal:noVal", "equals:noVal", "lBracket:noVal"])
        XCTAssertEqual(t2, ["rBracket:noVal", "addOperator:noVal", "subOperator:noVal", "timesOperator:noVal"])
        XCTAssertEqual(t3, ["divOperator:noVal", "expOperator:noVal", "noToken:noVal"])
        
    }
    
    /// this is not the best test of the consolidation func as it depends also on the parsing func working
    /// but i'm too lazy to write the token stream parse gives back by hand
    func testConsolidation() {
        let t1 = parser.parse("123 4 ")
        let t2 = parser.parse("abc d")
        
        XCTAssertEqual(t1, ["number:123", "number:4"])
        XCTAssertEqual(t2, ["letter:abc", "letter:d"])
    }

}
