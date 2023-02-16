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
}
