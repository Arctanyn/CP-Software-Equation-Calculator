//
//  BasicMathOperationButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct BasicMathOperationButton: View {
    @EnvironmentObject private var viewModel: EquationInputViewModel
    let mathOperation: BasicMathOperation
    
    var body: some View {
        Button {
            viewModel.addBasicOperation(mathOperation)
        } label: {
            ZStack {
                Rectangle()
                
                Text(mathOperation.title)
                    .font(.system(size: 35, weight: .semibold))
                    .foregroundColor(Color(.systemBackground))
            }
        }
        .tint(.primary)
    }
}

struct MathOperationButton_Previews: PreviewProvider {
    static var previews: some View {
        BasicMathOperationButton(mathOperation: .add)
    }
}
