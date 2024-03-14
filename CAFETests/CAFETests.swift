//
//  CAFETests.swift
//  CAFETests
//
//  Created by Aly Ashour on 2024-03-13.
//

import XCTest
@testable import CAFE

// this feature is so cool and so well designed im gonna cry
extension Array where Element == Token {
    func stringify() -> [String] {
        return self.map { $0.description }
    }
}

final class CAFETests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLexer() {
        let lexer = LineLexer()
        // test all symbols with random whitespace
        let t1 = lexer.tokenize("1 = (").stringify()
        let t2 = lexer.tokenize(") + - *").stringify()
        let t3 = lexer.tokenize("/ ^ & ").stringify()
        
        
        XCTAssertEqual(t1, ["number:1", "equals:noVal", "lBracket:("])
        XCTAssertEqual(t2, ["rBracket:)", "addOperator:noVal", "subOperator:noVal", "timesOperator:noVal"])
        XCTAssertEqual(t3, ["divOperator:noVal", "expOperator:noVal", "noToken:noVal"])
        
    }
    
    /// this is not the best test of the consolidation func as it depends also on the parsing func working
    /// but i'm too lazy to write the token stream parse gives back by hand
    func testConsolidation() {
        let lexer = LineLexer()
        
        let t1 = lexer.tokenize("12.3 4 ").stringify()
        let t2 = lexer.tokenize("abc d4").stringify()
        let t3 = lexer.tokenize("5.6.7 14epi").stringify()
        let t4 = lexer.tokenize("(pi * del) + ze.e").stringify()
        
        XCTAssertEqual(t1, ["double:12.3", "number:4"])
        XCTAssertEqual(t2, ["letter:abc", "letter:d4"])
        XCTAssertEqual(t3, ["noToken:5.6.7", "letter:14epi"])
        XCTAssertEqual(t4, ["lBracket:(", "letter:pi", "timesOperator:noVal", "letter:del", "rBracket:)", "addOperator:noVal", "letter:ze.e"])
    }

}
