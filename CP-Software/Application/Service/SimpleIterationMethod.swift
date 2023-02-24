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
    let function: ((Double) -> Double)
    
    private var iterationsInfo: [SimpleIterationInfo] = []
    
    //MARK: - Initialization
    
    init(equation: NSExpression,
         lowRangeLimit: Double,
         highRangeLimit: Double,
         epsilon: Double,
         function: @escaping (Double) -> Double) {
        self.equation = equation
        self.lowRangeLimit = lowRangeLimit
        self.highRangeLimit = highRangeLimit
        self.epsilon = epsilon
        self.function = function
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
        
        var x: Double = chooseStartPoint(between: a, and: b)
        
        let derivative = equation.derivative(at: x)
        let m = 1.01 * derivative
        
        var nextX = fi(x: x, m: m)
        var result: Double?
        
        var iteration = 1
        
        iterationsInfo.append(.init(iteration: iteration, x: x, m: m, functionDerivative: derivative))
        
        while abs(nextX - x) > eps {
            iteration += 1
            let nextIterationX = fi(x: nextX, m: m)
            
            if nextIterationX < a || nextIterationX > b {
                return nil
            } else if abs(nextIterationX - nextX) <= eps {
                result = nextIterationX
                break
            } else {
                iterationsInfo.append(.init(iteration: iteration, x: nextX, m: nil, functionDerivative: nil))
                x = nextX
                nextX = nextIterationX
            }
        }
        
        return result
    }
    
    func chooseStartPoint(between a: Double, and b: Double) -> Double {
        let almostZero = 0.000000000000001
        
        if a < b, a < 0, abs(a) >= abs(b) {
            return a != 0 ? a : almostZero
        } else {
            return b != 0 ? b : almostZero
        }
    }
    
    func fi(x: Double, m: Double) -> Double {
        x - function(x) / m
    }
}
