//
//  EquationInputViewModel.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 19.02.2023.
//

import Foundation

final class EquationInputViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var equation = String()
    
    var isEquationEmpty: Bool {
        equationComponents.isEmpty
    }
        
    @Published private var equationComponents = [String]()
    @Published private var equationExpressionComponents = [String]() {
        didSet {
            print(equationExpressionComponents)
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
    
    func addNumber(_ number: Int) {
        guard !checkTheLastIsClosingBracket() && !checkTheLastIsX() else { return }
        
        let strNumber = String(number)
        supplementEquation(withEquationComponents: strNumber, withEquationExpression: strNumber)
    }
    
    func addBasicOperation(_ operation: BasicMathOperation) {
        switch operation {
        case .add:
            if checkTheLastIsNumberOrClosingBracketOrX() {
                supplementEquation(withEquationComponents: "+", withEquationExpression: "+")
                allowsDot = true
            }
        case .sub:
            if isEquationEmpty || checkTheLastIsNumber() || checkTheLastIsBracket() || checkTheLastIsX() {
                supplementEquation(withEquationComponents: "-", withEquationExpression: "-")
                allowsDot = true
            }
        case .mul:
            if checkTheLastIsNumberOrClosingBracketOrX()  {
                supplementEquation(withEquationComponents: "×", withEquationExpression: "*")
                allowsDot = true
            }
        case .div:
            if checkTheLastIsNumberOrClosingBracketOrX() {
                supplementEquation(withEquationComponents: "/", withEquationExpression: "/")
                allowsDot = true
            }
        }
    }
    
    func addAuxiliaryOperation(_ operation: AuxiliaryMathOperation) {
        switch operation {
        case .dot:
            if checkTheLastIsNumber() && allowsDot {
                supplementEquation(withEquationComponents: ".", withEquationExpression: ".")
                allowsDot = false
            }
        case .x:
            if cheksForX() {
                supplementEquation(withEquationComponents: "x", withEquationExpression: "x")
            }
        case .roundBracket:
            if checkBracketsIsBalanced() {
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
        equationExpressionComponents.removeLast()
        
        if last == "." {
            allowsDot = true
        }
    }
    
    func addOpeningBracket() {
        guard !checkTheLastIsNumber() && !checkTheLastIsClosingBracket() && !checkTheLastIsX() else { return }
        supplementEquation(withEquationComponents: "(", withEquationExpression: "(")
    }
    
    func addClosingBracket() {
        guard checkTheLastIsNumber() || checkTheLastIsX() else { return }
        supplementEquation(withEquationComponents: ")", withEquationExpression: ")")
    }
    
}

//MARK: - Input Checks

private extension EquationInputViewModel {
    func checkTheLastIsNumberOrClosingBracket() -> Bool {
        return checkTheLastIsNumber() || checkTheLastIsClosingBracket()
    }
    
    func checkTheLastIsNumber() -> Bool {
        return Double(equationComponents.last ?? "") != nil
    }
    
    func checkTheLastIsBracket() -> Bool {
        return checkTheLastIsOpeningBracket() || checkTheLastIsClosingBracket()
    }
    
    func checkTheLastIsOpeningBracket() -> Bool {
        return equationComponents.last == "("
    }
    
    func checkTheLastIsClosingBracket() -> Bool {
        return equationComponents.last == ")"
    }
    
    func checkBracketsIsBalanced() -> Bool {
        equation.isBracketsBalanced()
    }
    
    func checkTheLastIsX() -> Bool {
        equation.last == "x"
    }
    
    func checkTheLastIsNumberOrClosingBracketOrX() -> Bool {
        checkTheLastIsNumberOrClosingBracket() || checkTheLastIsX()
    }
    
    func cheksForX() -> Bool {
        isEquationEmpty || (!checkTheLastIsNumber() && !checkTheLastIsClosingBracket() && !checkTheLastIsX())
    }
}
