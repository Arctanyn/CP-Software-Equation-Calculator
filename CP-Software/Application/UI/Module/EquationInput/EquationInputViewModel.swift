//
//  EquationInputViewModel.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 19.02.2023.
//

import Foundation

final class EquationInputViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var currentKeyboardSection: MathKeyboardSection = .numbersAndGeneralOperations
    
    @Published var equation = String()
    @Published private var equationComponents = [String]()
    
    let solutionMethods = EquationSolvingMethod.allCases
    
    var isReadyToSolve: Bool { equationComponents.contains("X") && equation.isBracketsBalanced() }
    
    var isEquationEmpty: Bool {
        equationComponents.isEmpty
    }
    
    private var isEndEnteringCustomOperation = true
    private var leftedCustomOperation: String?
    
    private var equationExpressionComponents = [String]() {
        didSet {
            print(equationExpressionComponents)
            print(equationExpressionComponents.joined())
        }
    }
    
    private var allowsDot = true
    
    //MARK: - Initialization
    
    init() {
        $equationComponents
            .map {
                $0.joined()
            }
            .assign(to: &$equation)
    }
    
    //MARK: - Methods
    
    func viewModelForEquationSolution(with method: EquationSolvingMethod) -> EquationSolutionViewModel {
        let equationExpression = equationExpressionComponents.joined().expression
        return EquationSolutionViewModel(
            equation: equation,
            equationExpression: equationExpression,
            solvingMethod: method
        )
    }
    
    func addNumber(_ number: Int) {
        guard !isLastClosingBracketOrX else { return }
        
        let strNumber = String(number)
        supplementEquation(withEquationComponents: strNumber, withEquationExpression: strNumber)
    }
    
    func addBasicOperation(_ operation: BasicMathOperation) {
        switch operation {
        case .add:
            if isLastNumberOrClosingBracketOrX {
                supplementEquation(withEquationComponents: "+", withEquationExpression: "+")
                allowsDot = true
            }
        case .sub:
            if checksForSubtraction {
                supplementEquation(withEquationComponents: "-", withEquationExpression: "-")
                allowsDot = true
            }
        case .mul:
            if isLastNumberOrClosingBracketOrX  {
                supplementEquation(withEquationComponents: "×", withEquationExpression: "*")
                allowsDot = true
            }
        case .div:
            if isLastNumberOrClosingBracketOrX {
                supplementEquation(withEquationComponents: "/", withEquationExpression: "/")
                allowsDot = true
            }
        }
    }
    
    func addAdvancedOperation(_ operation: AdvancedMathOperation) {
        switch operation {
        case .pow:
            if isLastNumberOrClosingBracket || isLastX {
                supplementEquation(withEquationComponents: "^(", withEquationExpression: "**(")
            }
        case .sqrt:
            if isEquationEmptyOrLastBasicOrOpeningBracket {
                supplementEquation(withEquationComponents: "sqrt(", withEquationExpression: "sqrt(")
            }
        case let someOperation where someOperation.isTrigonometric:
            if isEquationEmptyOrLastBasicOrOpeningBracket {
                supplementEquation(withEquationComponents: "\(operation.rawValue)(", withEquationExpression: "function(")
                isEndEnteringCustomOperation = false
                leftedCustomOperation = operation.rawValue
            }
        default:
            break
        }
    }
    
    func addAuxiliaryOperation(_ operation: AuxiliaryMathOperation) {
        switch operation {
        case .dot:
            if isLastNumber && allowsDot {
                supplementEquation(withEquationComponents: ".", withEquationExpression: ".")
                allowsDot = false
            }
        case .x:
            if isXPassedChecks {
                supplementEquation(withEquationComponents: "X", withEquationExpression: "X")
            }
        case .roundBracket:
            if isBracketsBalanced {
                addOpeningBracket()
            } else {
                addClosingBracket()
            }
        }
    }
    
    
    func removeLastOperation() {
        removeEquationsLastOperation()
    }
}

//MARK: - Private methods

private extension EquationInputViewModel {
    func supplementEquation(withEquationComponents component: String,
                            withEquationExpression expression: String) {
        equationComponents.append(component)
        equationExpressionComponents.append(expression)
    }
    
    func removeEquationsLastOperation() {
        let last = equationComponents.removeLast()
        let expressionLast = equationExpressionComponents.removeLast()
        
        if last == "." {
            allowsDot = true
        }
        
        if expressionLast.contains(",") {
            isEndEnteringCustomOperation = false
        }
    }
    
    func addOpeningBracket() {
        guard !isLastNumber && !isLastClosingBracket && !isLastX else { return }
        supplementEquation(withEquationComponents: "(", withEquationExpression: "(")
    }
    
    func addClosingBracket() {
        guard isLastNumber || isLastX || (!isWithinEmptyBreackets && !isLastContainsOpeningBracket) else { return }
        if !isEndEnteringCustomOperation, let leftedCustomOperation,
            equation.appending(")").isBracketsBalanced(),
            isLastNumberOrClosingBracketOrX {
            supplementEquation(withEquationComponents: ")", withEquationExpression: ", '\(leftedCustomOperation)')")
            isEndEnteringCustomOperation = true
        } else {
            supplementEquation(withEquationComponents: ")", withEquationExpression: ")")
        }
    }
    
}

//MARK: - Input Checks

private extension EquationInputViewModel {
    var isLastNumberOrClosingBracket: Bool { isLastNumber || isLastClosingBracket }
    
    var isLastNumber: Bool { Double(equationComponents.last ?? "") != nil }
    
    var checksForSubtraction: Bool { isEquationEmpty || isLastNumber || isLastBracket || isLastX }
    
    var isLastBracket: Bool { isLastOpeningBracket || isLastClosingBracket }
    
    var isLastOpeningBracket: Bool { equationComponents.last == "(" }
    
    var isLastClosingBracket: Bool { equationComponents.last == ")" }
    
    var isWithinEmptyBreackets: Bool { equation.hasSuffix("()") }
    
    var isBracketsBalanced: Bool { equation.isBracketsBalanced() }
    
    var isLastX: Bool { equationComponents.last == "X" }
    
    var isLastClosingBracketOrX: Bool { isLastClosingBracket || isLastX }
    
    var isLastNumberOrClosingBracketOrX: Bool { isLastNumberOrClosingBracket || isLastX }
    
    var isXPassedChecks: Bool { isEquationEmpty || (!isLastNumber && !isLastClosingBracket && !isLastX) }
    
    var isEquationEmptyOrLastBasicOrOpeningBracket: Bool {
        isEquationEmpty || isLastBasicOperation || isLastOpeningBracket
    }
    
    var isLastBasicOperation: Bool {
        guard let last = equationComponents.last else { return false }
        
        switch last {
        case "+", "-", "×", "/":
            return true
        default:
            return false
        }
    }
    
    var isLastContainsOpeningBracket: Bool {
        guard let last = equationComponents.last else { return false }
        return last.contains("(")
    }
}
