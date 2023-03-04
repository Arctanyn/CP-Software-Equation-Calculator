//
//  SimpleIterationMethod.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import Foundation

final class SimpleIterationMethod {
    
    //MARK: Properties
    
    let equation: NSExpression
    let lowRangeLimit: Double
    let highRangeLimit: Double
    let epsilon: Double
    
    private var iterationsInfo: [SimpleIterationInfo] = []
    
    //MARK: - Initialization
    
    init(equation: NSExpression,
         lowRangeLimit: Double,
         highRangeLimit: Double,
         epsilon: Double) {
        self.equation = equation
        self.lowRangeLimit = lowRangeLimit
        self.highRangeLimit = highRangeLimit
        self.epsilon = epsilon
    }
    
    //MARK: - Methods
    
    func solve() -> (answer: Double?, info: [SimpleIterationInfo]) {
        let answer = simpleIteration(a: lowRangeLimit, b: highRangeLimit, eps: epsilon)
        return (answer, iterationsInfo)
    }
}

//MARK: - Private methods

private extension SimpleIterationMethod {
    func simpleIteration(a: Double, b: Double, eps: Double) -> Double? {
        guard a < b else { return nil }
        
        var x = chooseStartPoint(between: a, and: b)
        
        let derivative = equation.derivative(at: x)
        let m = 1.01 * derivative
        
        var nextX = fi(x: x, m: m)
        var result: Double?
        
        var iteration = 1
        
        iterationsInfo.append(
            SimpleIterationInfo(
                iteration: iteration,
                x: x,
                m: m,
                functionDerivative: derivative
            )
        )
        
        while abs(nextX - x) > eps {
            iteration += 1
            let nextIterationX = fi(x: nextX, m: m)

            iterationsInfo.append(
                SimpleIterationInfo(
                    iteration: iteration,
                    x: nextIterationX,
                    m: nil, functionDerivative: nil
                )
            )
            
            guard (a...b).contains(nextIterationX) else { return nil }
            if abs(nextIterationX - nextX) <= eps {
                result = nextIterationX
                break
            } else {
                x = nextX
                nextX = nextIterationX
            }
        }
        
        return result
    }
    
    func chooseStartPoint(between a: Double, and b: Double) -> Double {
        if a < b, a < 0, abs(a) >= abs(b) {
            return a != 0 ? a : Double.almostZero
        } else {
            return b != 0 ? b : Double.almostZero
        }
    }
    
    func fi(x: Double, m: Double) -> Double {
        x - equation.expressionFunction(x: x) / m
    }
}
