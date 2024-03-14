//
//  LineViewModel.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-13.
//

import Foundation

class LineViewModel: ObservableObject {
    @Published var input: String = ""
    @Published var output: String = ""
    
    private let lineParser: LineParser
    
    init() {
        self.lineParser = LineParser()
    }
    
    public func updateOutput(){
        // let ast: AbstractSyntaxTree = lineParser.parse(input)
        output = input
    }
}
