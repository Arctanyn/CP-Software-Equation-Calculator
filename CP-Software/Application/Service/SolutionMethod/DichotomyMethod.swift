//
//  DichotomyMethod.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import Foundation

final class DichotomyMethod {

    //MARK: Properties
    
    let equation: NSExpression
    let lowRangeLimit: Double
    let highRangeLimit: Double
    let epsilon: Double
    
    private var iterationsInfo: [DichotomyIterationInfo] = []
    
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
    
    func solve() -> (answer: Double?, info: [DichotomyIterationInfo]) {
        let answer = dichotomy(a: lowRangeLimit, b: highRangeLimit, eps: epsilon)
        return (answer, iterationsInfo)
    }
}

//MARK: - Private methods

private extension DichotomyMethod {
    func dichotomy(a: Double, b: Double, eps: Double) -> Double? {
        var newA = a != 0 ? a : Double.almostZero
        var newB = b != 0 ? b : Double.almostZero
        
        var iteration = 0
        var result: Double?

        while abs(equation.expressionFunction(x: newB) - equation.expressionFunction(x: newA)) > eps {
            iteration += 1
            
            let midValue = (newA + newB) / 2
            
            iterationsInfo.append(
                .init(
                    iteration: iteration,
                    a: newA, b: newB,
                    x: midValue
                )
            )
            
            if midValue == 0 || abs(equation.expressionFunction(x: midValue)) < eps {
                result = midValue
                break
            } else if equation.expressionFunction(x: newA) * equation.expressionFunction(x: midValue) < 0 {
                newB = midValue
            } else {
                newA = midValue
            }
        }
        
        return result
    }
}
