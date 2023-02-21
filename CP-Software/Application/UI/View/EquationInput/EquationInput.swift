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
                            .font(.system(size: 25, weight: .medium, design: .rounded))
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
                
                ZStack {
                    if viewModel.isReadyToSolve {
                        solveButton
                    }
                }
                .transition(.opacity)
                .animation(.easeIn(duration: 0.2), value: viewModel.isReadyToSolve)
                
                
                MathKeyboard()
                    .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Calculator")
        }
        .environmentObject(viewModel)
    }
    
    private var solveButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Solve")
                Image(systemName: "arrow.right")
            }
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            .padding()
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.pink)
            }
        }
        .tint(.white)
    }
}

struct EquationInput_Previews: PreviewProvider {
    static var previews: some View {
        EquationInput()
    }
}
