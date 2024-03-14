//
//  Token.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-14.
//

public enum TokenType {
    case noToken    // for invalid tokens
    case blank      // for reducing tokens, this should not be used regularly in lexing
    case space
    case equals
    case lBracket
    case rBracket
    case addOperator
    case subOperator
    case timesOperator
    case divOperator
    case expOperator
    case number
    case double
    case letter
}

struct Token {
    let type: TokenType
    let value: String?
    
    init(type: TokenType, value: String? = nil) {
        self.type = type
        self.value = value
    }
    
    public var description: String {
        return "\(type):\(value ?? "noVal")"
    }
}
