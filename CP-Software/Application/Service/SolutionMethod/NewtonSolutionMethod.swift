//
//  NewtonSolutionMethod.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import Foundation

final class NewtonSolutionMethod {
    
    //MARK: Properties
    
    let equation: NSExpression
    let lowRangeLimit: Double
    let highRangeLimit: Double
    let epsilon: Double
    
    private var iterationsInfo: [NewtonIterationInfo] = []
    
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
    
    func solve() -> (answer: Double?, info: [NewtonIterationInfo]) {
        let answer = newton(a: lowRangeLimit, b: highRangeLimit, eps: epsilon)
        return (answer, iterationsInfo)
    }
}

//MARK: - Private methods

private extension NewtonSolutionMethod {
    func newton(a: Double, b: Double, eps: Double) -> Double? {
        guard a < b else { return nil }
        var x = chooseStartPoint(between: a, and: b)
        
        var result: Double?
        
        var iteration = 1
        var derivativeX = equation.derivative(at: x)
        let secondDerivativeX = equation.derivativeSecond(at: x)
        
        iterationsInfo.append(
            NewtonIterationInfo(
                iteration: iteration,
                derivative: derivativeX,
                secondDerivative: secondDerivativeX,
                x: x
            )
        )
        
        while abs(equation.expressionFunction(x: x)) > eps {
            iteration += 1
            
            derivativeX = equation.derivative(at: x)
            let nextX = x - (equation.expressionFunction(x: x) / derivativeX)
            
            iterationsInfo.append(
                NewtonIterationInfo(
                    iteration: iteration,
                    derivative: derivativeX,
                    secondDerivative: nil,
                    x: nextX
                )
            )
            
            guard (a...b).contains(nextX) else { return nil }
            if abs(equation.expressionFunction(x: nextX)) <= eps {
                result = nextX
                break
            } else {
                x = nextX
            }
        }
        
        return result
    }
    
    func chooseStartPoint(between a: Double, and b: Double) -> Double {
        let newA = a != 0 ? a : Double.almostZero
        let newB = b != 0 ? b : Double.almostZero
        
        if equation.expressionFunction(x: newA) * equation.derivativeSecond(at: newA) > 0 {
            return newA != Double.almostZero ? newA : newB
        } else {
            return newB
        }
    }
}
