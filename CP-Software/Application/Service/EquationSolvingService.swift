//
//  EquationSolvingService.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import Foundation

final class EquationSolvingService {
    
    //MARK: Properties
    
    private let equation: NSExpression
    private let solvingMethod: EquationSolvingMethod
    private let lowRangeLimit: Double
    private let highRangeLimit: Double
    private let epsilon: Double
    
    //MARK: - Initialization
    
    init(equation: NSExpression,
         solvingMethod: EquationSolvingMethod,
         lowRangeLimit: Double,
         highRangeLimit: Double,
         epsilon: Double) {
        self.equation = equation
        self.solvingMethod = solvingMethod
        self.lowRangeLimit = lowRangeLimit
        self.highRangeLimit = highRangeLimit
        self.epsilon = epsilon
    }
    
    //MARK: - Methods
    
    func function(x: Double) -> Double {
        equation.expressionFunction(x: x)
    }
    
    func solve() -> (answer: Double?, info: [Any]) {
        switch solvingMethod {
        case .dichotomy:
            let method = createDichotomyMethod()
            return method.solve()
        case .simpleIterations:
            let method = createSimpleIterationMethod()
            return method.solve()
        }
    }
}

//MARK: - Private methods

private extension EquationSolvingService {
    func createDichotomyMethod() -> DichotomyMethod {
        DichotomyMethod(
            lowRangeLimit: self.lowRangeLimit,
            highRangeLimit: self.highRangeLimit,
            epsilon: self.epsilon,
            function: self.function)
    }
    
    func createSimpleIterationMethod() -> SimpleIterationMethod {
        SimpleIterationMethod(
            equation: self.equation,
            lowRangeLimit: self.lowRangeLimit,
            highRangeLimit: self.highRangeLimit,
            epsilon: self.epsilon,
            function: function
        )
    }
}
