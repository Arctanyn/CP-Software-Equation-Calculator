//
//  AdvancedMathOperation.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 01.03.2023.
//

enum AdvancedMathOperation: String, CaseIterable {
    case pow
    case sqrt
    case sin, asin, sinh, asinh
    case cos, acos, cosh, acosh
    case tan, atan, tanh, atanh
    case cot, acot, coth, acoth
    
    case e
    case exp
    case log2
    case lg
    case ln
    
    var title: String {
        switch self {
        case .pow: return "^"
        case .sqrt: return "√"
        case .sin: return "sin"
        case .asin: return "asin"
        case .sinh: return "sinh"
        case .asinh: return "asinh"
        case .cos: return "cos"
        case .acos: return "acos"
        case .cosh: return "cosh"
        case .acosh: return "acosh"
        case .tan: return "tan"
        case .atan: return "atan"
        case .tanh: return "tanh"
        case .atanh: return "atanh"
        case .cot: return "cot"
        case .acot: return "acot"
        case .coth: return "coth"
        case .acoth: return "acoth"
        case .e: return "e"
        case .exp: return "exp"
        case .log2: return "log2"
        case .lg: return "lg"
        case .ln: return "ln"
        }
    }
    
    var isCustomExpressionFunction: Bool {
        switch self {
        case .pow, .sqrt:
            return false
        case .sin, .asin, .sinh, .asinh:
            return true
        case .cos, .acos, .cosh, .acosh:
            return true
        case .tan, .atan, .tanh, .atanh:
            return true
        case .cot, .acot, .coth, .acoth:
            return true
        case .e, .exp:
            return false
        case .log2:
            return true
        case .lg, .ln:
            return false
        }
    }
}
