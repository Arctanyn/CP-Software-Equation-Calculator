//
//  MathKeyboard.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct MathKeyboard: View {
    @EnvironmentObject private var viewModel: EquationInputViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                viewModel.removeLastOperation()
            } label: {
                Image(systemName: "delete.left")
                    .font(.system(size: 30))
                    .padding()
            }
            .tint(.primary)
            .disabled(viewModel.isEquationEmpty)

            HStack(alignment: .top, spacing: 20) {
                VStack(spacing: 2) {
                    AdvancedMathOperationButton(mathOperation: .pow)
                    AdvancedMathOperationButton(mathOperation: .sqrt)
                    AuxiliaryMathOperationButton(mathOperation: .roundBracket)
                    AuxiliaryMathOperationButton(mathOperation: .x)
                }
                
                NumbersPad()
                BasicMathOperationsPad()
            }
        }
    }
}

struct MathKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        MathKeyboard()
            .environmentObject(EquationInputViewModel())
    }
}
