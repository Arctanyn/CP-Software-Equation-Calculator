//
//  MathOperation.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

//MARK: BasicMathOperation

enum BasicMathOperation {
    case add
    case sub
    case mul
    case div
    
    var title: String {
        switch self {
        case .add: return "+"
        case .sub: return "-"
        case .mul: return "×"
        case .div: return "÷"
        }
    }
}

//MARK: - AdvancedMathOperation

enum AdvancedMathOperation {
    case pow
    case sqrt
    
    var title: String {
        switch self {
        case .pow: return "^"
        case .sqrt: return "√"
        }
    }
}

//MARK: - AuxiliaryMathOperation

enum AuxiliaryMathOperation {
    case dot
    case x
    case roundBracket
    
    var title: String {
        switch self {
        case .dot: return "."
        case .x: return "x"
        case .roundBracket: return "()"
        }
    }
}
