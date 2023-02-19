//
//  EquationInputViewModel.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 19.02.2023.
//

import Foundation

final class EquationInputViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published private(set) var equation = String()
    
    var isEquationEmpty: Bool {
        equationComponents.isEmpty
    }
    
    @Published private var equationComponents = [String]()
    @Published private var equationExpressionComponents = [String]() {
        didSet {
            print(equationExpressionComponents)
        }
    }
    
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
        let strNumber = String(number)
        
        equationComponents.append(strNumber)
        equationExpressionComponents.append(strNumber)
    }
    
    func addBasicOperation(_ operation: BasicMathOperation) {
        switch operation {
        case .add:
            if checkTheLastIsNumberOrClosingBracket() {
                supplementEquation(withEquationComponents: "+", withEquationExpression: "+")
            }
        case .sub:
            if isEquationEmpty || checkTheLastIsNumber() || checkTheLastIsBracket() {
                supplementEquation(withEquationComponents: "-", withEquationExpression: "-")
            }
        case .mul:
            if checkTheLastIsNumberOrClosingBracket()  {
                supplementEquation(withEquationComponents: "×", withEquationExpression: "*")
            }
        case .div:
            if checkTheLastIsNumberOrClosingBracket() {
                supplementEquation(withEquationComponents: "/", withEquationExpression: "/")
            }
        }
    }
    
    func removeLastOperation() {
        removeEquationsLastOperation()
    }
}

//MARK: - Private methods

private extension EquationInputViewModel {
    func supplementEquation(withEquationComponents component: String, withEquationExpression expression: String) {
        equationComponents.append(component)
        equationExpressionComponents.append(expression)
    }
    
    func removeEquationsLastOperation() {
        equationComponents.removeLast()
        equationExpressionComponents.removeLast()
    }
    
    func checkTheLastIsNumberOrClosingBracket() -> Bool {
        return checkTheLastIsNumber() || checkTheLastIsClosingBracket()
    }
    
    func checkTheLastIsNumber() -> Bool {
        guard
            let last = equationComponents.last,
            Double(last) != nil
        else { return false }
        return true
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
}
