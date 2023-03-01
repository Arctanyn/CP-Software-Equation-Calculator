//
//  NumberButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct NumberButton: View {
    @EnvironmentObject private var viewModel: EquationInputViewModel
    let number: Int
    
    var body: some View {
        Button {
            viewModel.addNumber(number)
        } label: {
            ZStack {
                Rectangle()
                
                Text(String(number))
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
        }
        .tint(Color(.secondarySystemBackground))
    }
}

struct NumberButton_Previews: PreviewProvider {
    static var previews: some View {
        NumberButton(number: 1)
    }
}
