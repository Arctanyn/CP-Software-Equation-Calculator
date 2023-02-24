//
//  DichotomyMethod.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import Foundation

class DichotomyMethod {

    //MARK: Properties
    
    let lowRangeLimit: Double
    let highRangeLimit: Double
    let epsilon: Double
    let function: ((Double) -> Double)
    
    private var iterationsInfo: [DichotomyIterationInfo] = []
    
    //MARK: - Initialization
    
    init(lowRangeLimit: Double,
         highRangeLimit: Double,
         epsilon: Double,
         function: @escaping (Double) -> Double) {
        self.lowRangeLimit = lowRangeLimit
        self.highRangeLimit = highRangeLimit
        self.epsilon = epsilon
        self.function = function
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
        let almostZero = 0.000000000000001
        
        var newA = a != 0 ? a : almostZero
        var newB = b != 0 ? b : almostZero
        
        var iteration = 0
        var result: Double?

        while abs(function(newB) - function(newA)) > eps {
            iteration += 1
            
            let midValue = (newA + newB) / 2
            
            iterationsInfo.append(
                .init(
                    iteraction: iteration,
                    a: newA, b: newB,
                    x: midValue
                )
            )
            
            if midValue == 0 || abs(function(midValue)) < eps {
                result = midValue
                break
            } else if function(newA) * function(midValue) < 0 {
                newB = midValue
            } else {
                newA = midValue
            }
        }
        
        return result
    }
}
