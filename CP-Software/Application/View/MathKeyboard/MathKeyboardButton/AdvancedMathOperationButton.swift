//
//  AdvancedMathOperationButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct AdvancedMathOperationButton: View {
    let mathOperation: AdvancedMathOperations
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                
                Text(mathOperation.title)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.primary)
            }
        }
        .tint(.secondary.opacity(0.4))
        .frame(width: 65, height: 65)
    }
}

struct AdvancedMathOperationButton_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedMathOperationButton(mathOperation: .pow)
    }
}