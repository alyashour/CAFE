//
//  LineParser.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-14.
//

class LineParser {
    private let lineLexer = LineLexer()
    
    public func parse(_ input: String){
        var tokenStream = lineLexer.tokenize(input)
        reformat(&tokenStream)
    }
    
    /// Reformat token stream to always be in the form function(a, b) for all operations
    private func reformat(_ stream: inout [Token]) {
        var iterator = stream.makeIterator();
        
        while let next = iterator.next() {
            
        }
    }
}
