//
//  EquationInput.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct EquationInput: View {
    @StateObject private var viewModel = EquationInputViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(
                        viewModel.isEquationEmpty ? "Type an equation..." : viewModel.equation
                    )
                    .font(.system(size: 25))
                    .foregroundColor(
                        viewModel.isEquationEmpty ? .secondary : .primary
                    )
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                MathKeyboard()
                    .padding(.bottom)
            }
            .navigationTitle("Calculator")
        }
        .environmentObject(viewModel)
    }
}

struct EquationInput_Previews: PreviewProvider {
    static var previews: some View {
        EquationInput()
    }
}
