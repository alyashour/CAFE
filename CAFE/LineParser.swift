//
//  LineParser.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-13.
//
public enum TokenType {
    case noToken    // for invalid tokens
    case decimal // this includes decimal points
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
    case letter
}

class LineParser {
    private struct Token {
        let type: TokenType
        let value: String?
        
        public var description: String {
            return "\(type):\(value ?? "noVal")"
        }
    }
    
    /// todo, read below:
    /// For future note, this should probably return an object containing all the data calculated NOT a string.
    /// I should instead be able to call toString on that object to print it. But for now, A string will do
    public func parse(_ input: String) -> [String] {
        let tokens: [Token] = tokenize(input)
        return tokens.map({ $0.description })
    }
    
    /// finished
    /// this returns an array of consolidated tokens with no whitespaces
    private func tokenize(_ input: String) -> [Token] {
        var tokens = [Token]()
        
        // tokenize
        for char in input {
            // identify token type
            var type: TokenType
            if char.isLetter { type = .letter } // letters
            else if char.isNumber { type = .number } // numbers
            else {
                type = switch(char) {
                case ".", ",":
                    .decimal
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
            
            // identify token value (if applicable)
            let valuableTypes: [TokenType] = [.number, .letter]
            var value: String? = nil
            if valuableTypes.contains(type) {
                value = String(char)
            }
            
            // append a new token to tokens
            tokens.append(Token(type: type, value: value))
        }
        
        // consolidate
        tokens = consolidate(tokens)
        
        // remove whitespace
        tokens = tokens.filter({ $0.type != .space })
        
        return tokens
    }
    
    ///  finished
    /// Combines Similar tokens together into 1 single token with their concatenated value
    /// E.g., Number and Letter tokens that are directly beside eachother are consolidated into single tokens with their cumulative value
    ///  - Parameter input:
    private func consolidate(_ input: [Token]) -> [Token] {
        let mergeableTypes: [TokenType] = [.number, .letter]
        var arr = [Token]() // the new array to be returned
        var buffer = [Token]() // a buffer to hold the parts being consolidated
        
        for token in input {
            // if the type can be consolidated
            let isMergeable: Bool = mergeableTypes.contains(token.type)
            let endsMergeableBlock: Bool = !isMergeable && !buffer.isEmpty
            
            if isMergeable {
                buffer.append(token) // add the token to the buffer
                continue
            }
            else if endsMergeableBlock {
                // make a larger token out of the buffer (not including the current token)
                let newValue = buffer
                    .map() {$0.value ?? "noVal"} // only care about tokens
                    .reduce("") {$0 + $1} // concatenate them together
                
                let newType = buffer
                    .map({$0.type})
                    .reduce(TokenType.number) { (a, b) in
                    // there is a precidence to blocks
                    // if it contains a letter it should be letters, if it contains only numbers it should be number
                        if a == TokenType.letter || b == TokenType.letter { return TokenType.letter }
                        else { return TokenType.number }
                    }
                
                // append the merged token to the revised token list
                arr.append(Token(type: newType, value: newValue))
            }
            
            // append the current token
            arr.append(token)
            buffer.removeAll() // reset buffer
        }
        
        // iff the last token in the array was mergeable, there will be one more value in the bufferx
        if !buffer.isEmpty {
            arr.append(buffer.first!) // this should never be null
        }
        
        return arr
    }
    
    /// todo
    /// This takes
    private func parseTokens(_ input: [Token]) {
        
    }
}
