//
//  DichotomySolutionViewModel.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 21.02.2023.
//

import Foundation
import Combine

final class DichotomySolutionViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var epsilon = 0.001
    @Published var lowSearchRangeText = String()
    @Published var highSearchRangeText = String()
    @Published var interimResults: [DichotomyIterationInfo] = []
    
    @Published private var lowSearchRange: Double?
    @Published private var highSearchRange: Double?
    
    private(set) var answer: Double?
    
    var isSolveButtonEnable: Bool {
        guard
            let lowSearchRange, let highSearchRange,
            lowSearchRange < highSearchRange,
            abs(lowSearchRange) - abs(highSearchRange) != 0
        else { return false }
        return true
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    let equation: String
    private let equationExpression: NSExpression
    
    //MARK: - Initialization
    
    init(equation: String, equationExpression: NSExpression) {
        self.equation = equation
        self.equationExpression = equationExpression

        $lowSearchRangeText
            .compactMap { Double($0) }
            .assign(to: &$lowSearchRange)
        
        $highSearchRangeText
            .compactMap { Double($0) }
            .assign(to: &$highSearchRange)
    }
    
    //MARK: - Methods
    
    func calculate() {
        guard let lowSearchRange, let highSearchRange else { return }
        interimResults.removeAll()
        answer = dichotomy(a: lowSearchRange, b: highSearchRange, eps: epsilon)
    }
    
    func function(x: Double) -> Double {
        guard
            x != 0,
            let value = equationExpression.expressionValue(with: ["X": x], context: nil) as? Double
        else { fatalError() }
        
        return value
    }
}

//MARK: - Private methods

private extension DichotomySolutionViewModel {
    func dichotomy(a: Double, b: Double, eps: Double) -> Double? {
        let almostZero = 0.000000000000001
        
        var newA = a != 0 ? a : almostZero
        var newB = b != 0 ? b : almostZero
        
        var iteration = 0
        var result: Double?

        while abs(function(x: newB) - function(x: newA)) > eps {
            iteration += 1
            
            let midValue = (newA + newB) / 2
            
            interimResults.append(
                .init(
                    iteraction: iteration,
                    epsilon: epsilon,
                    a: newA, b: newB,
                    x: midValue
                )
            )
            
            if midValue == 0 || abs(function(x: midValue)) < eps {
                result = midValue
                break
            } else if function(x: newA) * function(x: midValue) < 0 {
                newB = midValue
            } else {
                newA = midValue
            }
        }
        
        return result
    }
}
