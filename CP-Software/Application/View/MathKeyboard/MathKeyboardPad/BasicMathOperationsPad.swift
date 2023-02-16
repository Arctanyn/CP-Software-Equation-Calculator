//
//  BasicMathOperationsPad.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct BasicMathOperationsPad: View {
    var body: some View {
        VStack(spacing: 2) {
            BasicMathOperationButton(mathOperation: .div)
            BasicMathOperationButton(mathOperation: .mul)
            BasicMathOperationButton(mathOperation: .sub)
            BasicMathOperationButton(mathOperation: .add)
        }
    }
}

struct BasicMathOperationsPad_Previews: PreviewProvider {
    static var previews: some View {
        BasicMathOperationsPad()
    }
}
