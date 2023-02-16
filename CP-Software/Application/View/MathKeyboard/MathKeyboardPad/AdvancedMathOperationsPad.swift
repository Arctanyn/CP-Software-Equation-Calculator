//
//  AdvancedMathOperationsPad.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct AdvancedMathOperationsPad: View {
    var body: some View {
        VStack(spacing: 2) {
            AdvancedMathOperationButton(mathOperation: .pow)
            AdvancedMathOperationButton(mathOperation: .sqrt)
        }
    }
}

struct AdvancedMathOperationsPad_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedMathOperationsPad()
    }
}
