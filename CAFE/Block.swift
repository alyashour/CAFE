//
//  Block.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-14.
//
typealias Operation = ([Double]) -> Double

protocol Evaluatable {
    func evaluate() -> Double
}

struct Block : Evaluatable {
    let operation: Operation?
    let params: [Evaluatable?]? // holy crap thats a lot of question marks
    
    func evaluate() -> Double {
        return operation!(params!.map{ $0!.evaluate() })
    }
}

struct Value: Evaluatable {
    let value: Double
    
    func evaluate() -> Double {
        return value
    }
}
