//
//  NSExpression + Ext.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 23.02.2023.
//

import Foundation

extension NSExpression {
    func expressionFunction(x: Double) -> Double {
        guard
            x != 0,
            let value = expressionValue(with: ["X": x], context: nil) as? Double
        else { fatalError() }
        return value
    }
    
    func derivative(at x: Double) -> Double {
        let h = 0.0000001
        return (expressionFunction(x: x + h) - expressionFunction(x: x)) / h
    }
    
    func derivativeSecond(at x: Double) -> Double {
        let h = 0.0000001
        return (expressionFunction(x: x + h) - 2 * expressionFunction(x: x) + expressionFunction(x: x - h)) / pow(h, 2)
    }
}
