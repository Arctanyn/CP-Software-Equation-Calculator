//
//  EquationSolution.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import SwiftUI

struct EquationSolution: View {
    @StateObject var viewModel: EquationSolutionViewModel
    
    var body: some View {
        List {
            Section {
                SolutionSearchParametersRepresentation()
            }
            .environmentObject(viewModel)
            
            if !viewModel.iterationsInfo.isEmpty {
                Section {
                    SolvingSteps(
                        solvingMethod: viewModel.solvingMethod,
                        iterationsInfo: viewModel.iterationsInfo
                    )
                } footer: {
                    VStack(alignment: .leading) {
                        if let answer = viewModel.answer {
                            Answer(
                                answer: answer,
                                functionValue: viewModel.getFunctionValue(with: answer)
                            )
                        } else {
                            Text("No solution")
                                .padding(.vertical)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 200)
                }
            }
        }
        .onTapGesture {
            endEditing()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.solvingMethod.rawValue)
        .overlay {
            VStack {
                Spacer()
                ZStack {
                    if viewModel.isSolveButtonEnable {
                        SolveButton {
                            endEditing()
                            viewModel.solve()
                        }
                        .transition(.opacity.animation(.easeIn(duration: 0.2)))
                        .padding()
                    }
                }
            }
        }
    }
}

struct EquationSolution_Previews: PreviewProvider {
    static let equation = "X**4-2*X-4"
    static var previews: some View {
        EquationSolution(
            viewModel: EquationSolutionViewModel(
                equation: equation,
                equationExpression: equation.expression,
                solvingMethod: .dichotomy
            )
        )
    }
}
