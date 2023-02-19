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
                ScrollViewReader { scrollView in
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text(
                                viewModel.isEquationEmpty ? "Type an equation..." : viewModel.equation
                            )
                            .font(.system(size: 25))
                            .foregroundColor(
                                viewModel.isEquationEmpty ? .secondary : .primary
                            )
                            .id("Equation")
                        }
                        .onChange(of: viewModel.equation) { _ in
                            withAnimation {
                                scrollView.scrollTo("Equation", anchor: .trailing)
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                MathKeyboard()
                    .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
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
