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
    @Published var lowSearchRangeText = String()
    @Published var highSearchRangeText = String()
    @Published var iterationsInfo: [Any] = []
        
    @Published private var epsilon: Double?
    @Published private var lowSearchRange: Double?
    @Published private var highSearchRange: Double?

    var isSolveButtonEnable: Bool {
        determineSolutionAvailability()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    let equation: String
    private let equationExpression: NSExpression
    let solvingMethod: EquationSolvingMethod
    private(set) var answer: Double?
    
    private var solvingService: EquationSolvingService?
    
    //MARK: - Initialization
    
    init(equation: String, equationExpression: NSExpression, solvingMethod: EquationSolvingMethod) {
        self.equation = equation
        self.equationExpression = equationExpression
        self.solvingMethod = solvingMethod
        makeBindings()
    }
    
    //MARK: - Methods
    
    func solve() {
        guard let lowSearchRange, let highSearchRange, let epsilon else { return }
        
        iterationsInfo.removeAll()
        
        let solvingService = EquationSolvingService(
            equation: self.equationExpression,
            solvingMethod: self.solvingMethod,
            lowRangeLimit: lowSearchRange, highRangeLimit: highSearchRange,
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
    func makeBindings() {
        $lowSearchRangeText
            .compactMap { Double($0) }
            .assign(to: &$lowSearchRange)
        
        $highSearchRangeText
            .compactMap { Double($0) }
            .assign(to: &$highSearchRange)
        
        $epsilonValueText
            .compactMap { Double($0) }
            .map {
                if $0 > 0 {
                    return $0
                } else {
                    return nil
                }
            }
            .assign(to: &$epsilon)
    }
    
    func determineSolutionAvailability() -> Bool {
        guard
            epsilon != nil,
            let lowSearchRange, let highSearchRange,
            lowSearchRange < highSearchRange
        else { return false }
        
        switch solvingMethod {
        case .dichotomy:
            return abs(lowSearchRange) - abs(highSearchRange) != 0
        default:
            break
        }
        
        return true
    }
}
