//
//  LineParser.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-13.
//

class LineLexer {
    private let mergeableTypes: [TokenType] = [.number, .double, .letter]
    private let valuableTypes: [TokenType] = [.lBracket, .rBracket, .number, .double, .letter] // types that can have a value
    
    /// This tokenizes an input string into lexical tokens for analysis (parsing).
    /// Tokens are already consolidated (ints, doubles, and variable names are combined into larger tokens)
    /// and white space is removed.
    /// For future note, this will return an object containing all the data calculated NOT a string at some point
    /// I should instead be able to call toString on that object to print it. But for now, A string will do
    public func tokenize(_ input: String) -> [Token] {
        var tokens: [Token] = tokenizeCharacters(input)
        consolidate(&tokens)
        removeWhiteSpaceTokens(&tokens)
        return tokens
    }
    
    private func removeWhiteSpaceTokens(_ tokens: inout [Token]) {
        tokens = tokens.filter({ $0.type != .space })
    }
    
    private func identifyTokenType(_ c: Character) -> TokenType {
        var type: TokenType
        if c.isLetter { type = .letter } // letters
        else if c.isNumber { type = .number } // numbers
        else {
            type = switch(c) {
            case ".", ",":
                .double
            case " ":
                .space
            case "=":
                .equals
            case "(", "[", "{":
                .lBracket
            case ")", "]", "}":
                .rBracket
            case "+":
                .addOperator
            case "-", "−":
                .subOperator
            case "x", "×", "⋅", "*":
                .timesOperator
            case "/", "\\", "÷":
                .divOperator
            case "^":
                .expOperator
            default:
                .noToken
            }
        }
        
        return type
    }
    
    /// Divides input nto single character tokens
    private func tokenizeCharacters(_ input: String) -> [Token] {
        var tokens = [Token]()
        
        // tokenize
        for char in input {
            // identify token type
            let type: TokenType = identifyTokenType(char)
            
            // identify token value (if applicable)
            var value: String? = nil
            if valuableTypes.contains(type) {
                value = String(char)
            }
            
            // append a new token to tokens
            tokens.append(Token(type: type, value: value))
        }
        
        return tokens
    }
    
    /// Combines mergeable tokens together into larger tokens with their concatenated value depending on their seperation.
    /// Mergeable types are combined into blocks fed into a buffer. Non-mergeable types seperate blocks.
    /// Non-mergeable types are:
    /// - All operators
    /// - Spaces
    /// - Brackets
    ///  - Parameter input:
    private func consolidate(_ input: inout [Token]) {
        var arr = [Token]() // the new array to be returned
        var buffer = [Token]() // a buffer to hold the parts being consolidated
        
        // add a block seperator to the end of the input array to
        // ensure it captures the final block
        input.append(Token(type: .space))
        
        for token in input {
            // if the type can be consolidated
            let isBlockSeperator: Bool = !mergeableTypes.contains(token.type)
            
            if (isBlockSeperator) {
                // if the buffer has data
                if (!buffer.isEmpty) {
                    let tokenFromBuffer = concatenateBufferContents(buffer)
                    arr.append(tokenFromBuffer)
                    buffer.removeAll()
                }
                
                // add the block seperator token
                arr.append(token)
            } 
            
            else {
                buffer.append(token)
            }
        }

    
        // mutate the array
        input = arr
    }
    
    /// Combines tokens in a single buffer into a larger token.
    /// The buffer can only contain mergeable types
    /// These rules (in order of precedence):
    /// - Anything with a letter token -> word token
    /// - Multiple numbers -> number token
    /// - 1 double and multiple numbers -> double token
    /// - Anything else yields a block with type=.noToken
    private func concatenateBufferContents(_ buffer: [Token]) -> Token {
        // assert all values are mergeable
        assert (buffer.allSatisfy({ mergeableTypes.contains($0.type) }))
        return buffer
            .reduce(Token(type: .blank)) { (x, y) in
                
                var type: TokenType = .noToken
                let a = x.type
                let b = y.type
                let ab = [a, b]
                
                // if x is a blank type token, return y
                if (x.type == .blank) { return y }
                
                // if either of the tokens are letters, the block is a letter
                if ab.contains(.letter) { type = .letter }
                // if both are numbers, the block is a number
                else if ab.allSatisfy({ $0 == .number }) { type = .number }
                // if both are doubles, the block is invalid
                else if ab.allSatisfy({ $0 == .double }) { type = .noToken }
                
                // if 1 is a double and the other is a number, the block is a double
                else if ab.contains(.double) && ab.contains(.number)
                    { type = .double}
                
                let value = x.value! + y.value!
                
                return Token(type: type, value: value)
            }
    }
}
