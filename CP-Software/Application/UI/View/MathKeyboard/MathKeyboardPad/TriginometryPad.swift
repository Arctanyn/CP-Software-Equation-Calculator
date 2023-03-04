//
//  TriginometryPad.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 04.03.2023.
//

import SwiftUI

struct TriginometryPad: View {
    var body: some View {
        HStack(spacing: 2) {
            VStack(spacing: 2) {
                AdvancedMathOperationButton(mathOperation: .sin)
                AdvancedMathOperationButton(mathOperation: .asin)
                AdvancedMathOperationButton(mathOperation: .sinh)
                AdvancedMathOperationButton(mathOperation: .asinh)
            }
            
            VStack(spacing: 2) {
                AdvancedMathOperationButton(mathOperation: .cos)
                AdvancedMathOperationButton(mathOperation: .acos)
                AdvancedMathOperationButton(mathOperation: .cosh)
                AdvancedMathOperationButton(mathOperation: .acosh)
            }
            
            VStack(spacing: 2) {
                AdvancedMathOperationButton(mathOperation: .tan)
                AdvancedMathOperationButton(mathOperation: .atan)
                AdvancedMathOperationButton(mathOperation: .tanh)
                AdvancedMathOperationButton(mathOperation: .atanh)
            }
            
            VStack(spacing: 2) {
                AdvancedMathOperationButton(mathOperation: .cot)
                AdvancedMathOperationButton(mathOperation: .acot)
                AdvancedMathOperationButton(mathOperation: .coth)
                AdvancedMathOperationButton(mathOperation: .acoth)
            }

        }
    }
}

struct TriginometryPad_Previews: PreviewProvider {
    static var previews: some View {
        TriginometryPad()
    }
}
