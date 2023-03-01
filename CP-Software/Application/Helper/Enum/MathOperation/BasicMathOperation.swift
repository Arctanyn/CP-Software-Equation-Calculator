//
//  BasicMathOperation.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

enum BasicMathOperation: String {
    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"
    
    var title: String {
        switch self {
        case .add: return "+"
        case .sub: return "-"
        case .mul: return "×"
        case .div: return "÷"
        }
    }
}
