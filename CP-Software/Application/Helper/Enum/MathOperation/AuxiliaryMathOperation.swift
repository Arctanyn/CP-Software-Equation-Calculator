//
//  AuxiliaryMathOperation.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 01.03.2023.
//

enum AuxiliaryMathOperation {
    case dot
    case x
    case roundBracket
    
    var title: String {
        switch self {
        case .dot: return "."
        case .x: return "X"
        case .roundBracket: return "(...)"
        }
    }
}
