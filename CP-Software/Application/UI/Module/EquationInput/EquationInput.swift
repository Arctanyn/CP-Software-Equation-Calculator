//
//  EquationInput.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct EquationInput: View {
    @StateObject private var viewModel = EquationInputViewModel()
    @State private var isConfirmationPresented = false
    private let equationTextId = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        Text(
                            viewModel.isEquationEmpty ? "Type an equation..." : viewModel.equation
                        )
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(
                            viewModel.isEquationEmpty ? .secondary : .primary
                        )
                        .padding(.vertical)
                        .id(equationTextId)
                        .onChange(of: viewModel.equation) { _ in
                            scrollView.scrollTo(equationTextId, anchor: .trailing
                            )
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
                    .frame(maxHeight: 450)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Calculator")
            .navigationDestination(for: EquationSolvingMethod.self) { solutionMethod in
                EquationSolution(viewModel: viewModel.viewModelForEquationSolution(with: solutionMethod))
            }
        }
        .tint(.pink)
        .environmentObject(viewModel)
    }
    
    private var solveButton: some View {
        Button {
            isConfirmationPresented.toggle()
        } label: {
            HStack {
                Text("Show solution")
                Image(systemName: "arrow.right")
            }
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.pink)
            }
        }
        .confirmationDialog("Solution methods", isPresented: $isConfirmationPresented, actions: {
            ForEach(viewModel.solutionMethods, id: \.self) { solutionMehod in
                NavigationLink(solutionMehod.rawValue, value: solutionMehod)
            }
        }, message: {
            Text("Choose a method for solving the equation")
        })
        .tint(.white)
    }
}

struct EquationInput_Previews: PreviewProvider {
    static var previews: some View {
        EquationInput()
    }
}
