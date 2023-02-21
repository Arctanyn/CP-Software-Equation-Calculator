//
//  AuxiliaryMathOperationButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct AuxiliaryMathOperationButton: View {
    @EnvironmentObject private var viewModel: EquationInputViewModel
    let mathOperation: AuxiliaryMathOperation
    
    var body: some View {
        Button {
            viewModel.addAuxiliaryOperation(mathOperation)
        } label: {
            ZStack {
                Rectangle()
                
                Text(mathOperation.title)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.primary)
            }
        }
        .tint(.secondary.opacity(0.2))
        .frame(width: 65, height: 65)
    }
}

struct AuxiliaryMathOperationButton_Previews: PreviewProvider {
    static var previews: some View {
        AuxiliaryMathOperationButton(mathOperation: .roundBracket)
    }
}
