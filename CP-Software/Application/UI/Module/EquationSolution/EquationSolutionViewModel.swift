//
//  EquationSolutionViewModel.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import Foundation
import Combine

final class EquationSolutionViewModel: ObservableObject {
    
    //MARK: Properties
        
    @Published var epsilonValueText = String()
    @Published var lowSearchRangeLimitText = String()
    @Published var highSearchRangeLimitText = String()
    @Published var iterationsInfo: [Any] = []
        
    @Published private var epsilon: Double?
    @Published private var lowSearchRangeLimit: Double?
    @Published private var highSearchRangeLimit: Double?
    
    private var previousLowSearchRangeLimit: Double?
    private var previousHighSearchRangeLimit: Double?
    private var previousEpsilonValue: Double?

    var isSolveButtonEnable: Bool {
        determineSolutionAvailability()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    let equation: String
    let solvingMethod: EquationSolvingMethod
    private let equationExpression: NSExpression
    
    private(set) var answer: Double?
    private var solvingService: EquationSolvingService?
    
    //MARK: - Initialization
    
    init(equation: String,
         equationExpression: NSExpression,
         solvingMethod: EquationSolvingMethod) {
        self.equation = equation
        self.equationExpression = equationExpression
        self.solvingMethod = solvingMethod
        makeBindings()
    }
    
    //MARK: - Methods
    
    func solve() {
        guard let lowSearchRangeLimit, let highSearchRangeLimit, let epsilon else { return }
        updateForNewSolution()
        
        let solvingService = EquationSolvingService(
            equation: self.equationExpression,
            solvingMethod: self.solvingMethod,
            lowRangeLimit: lowSearchRangeLimit, highRangeLimit: highSearchRangeLimit,
            epsilon: epsilon
        )
        self.solvingService = solvingService
        
        let (answer, iterationsInfo) = solvingService.solve()
        self.answer = answer
        self.iterationsInfo = iterationsInfo
    }
    
    func getFunctionValue(with x: Double) -> Double {
        return solvingService?.function(x: x) ?? 0
    }
}

//MARK: - Private methods

private extension EquationSolutionViewModel {
    var isPreviousValuesNotEntered: Bool {
        guard
            let previousLowSearchRangeLimit,
            let previousHighSearchRangeLimit,
            let previousEpsilonValue
        else { return true }
        
        return previousLowSearchRangeLimit != lowSearchRangeLimit ||
                previousHighSearchRangeLimit != highSearchRangeLimit ||
                previousEpsilonValue != epsilon
    }
    
    func makeBindings() {
        $lowSearchRangeLimitText
            .compactMap { Double($0) }
            .assign(to: &$lowSearchRangeLimit)
        
        $highSearchRangeLimitText
            .compactMap { Double($0) }
            .assign(to: &$highSearchRangeLimit)
        
        $epsilonValueText
            .compactMap { Double($0) }
            .map { $0 > 0 ? $0 : nil }
            .assign(to: &$epsilon)
    }
    
    func determineSolutionAvailability() -> Bool {
        guard
            epsilon != nil,
            let lowSearchRangeLimit, let highSearchRangeLimit,
            lowSearchRangeLimit < highSearchRangeLimit,
            isPreviousValuesNotEntered
        else { return false }
        
        switch solvingMethod {
        case .dichotomy:
            return abs(lowSearchRangeLimit) - abs(highSearchRangeLimit) != 0
        default:
            break
        }
        
        return true
    }
    
    func updateForNewSolution() {
        iterationsInfo.removeAll()
        assignPreviousValues()
    }
    
    func assignPreviousValues() {
        previousLowSearchRangeLimit = lowSearchRangeLimit
        previousHighSearchRangeLimit = highSearchRangeLimit
        previousEpsilonValue = epsilon
    }
}
