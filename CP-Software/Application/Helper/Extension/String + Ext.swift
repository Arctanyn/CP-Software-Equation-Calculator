//
//  String + Ext.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import Foundation

extension String {
    var expression: NSExpression {
        NSExpression(format: self)
    }
    
    func isBracketsBalanced() -> Bool {
        switch self.filter("()".contains).replacingOccurrences(of: "()", with: "") {
        case "":
            return true
        case self:
            return false
        case let next:
            return next.isBracketsBalanced()
        }
    }
}
