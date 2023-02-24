//
//  SimpleIterationSolutionView.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 23.02.2023.
//

import SwiftUI

struct SimpleIterationSolutionView: View {
    @ObservedObject var viewModel: EquationSolutionViewModel
    
    var body: some View {
        List {
            Section {
                SolutionSearchParametersRepresentation()
            }
            .environmentObject(viewModel)

            
            if let simpleIterationsInfo = viewModel.iterationsInfo as? [SimpleIterationInfo], !simpleIterationsInfo.isEmpty {
                Section {
                    ForEach(simpleIterationsInfo, id: \.iteration) { info in
                        SimpleIteration(iterationInfo: info)
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        if let answer = viewModel.answer {
                            Answer(
                                answer: answer,
                                functionValue: viewModel.getFunctionValue(with: answer)
                            )
                        } else {
                            Text("No solution")
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
        .navigationTitle("Simple Iterations")
        .overlay {
            VStack {
                Spacer()
                ZStack {
                    if viewModel.isSolveButtonEnable {
                        SolveButton {
                            viewModel.solve()
                            endEditing()
                        }
                        .padding()
                    }
                }
                .animation(.default, value: viewModel.isSolveButtonEnable)
                .transition(.opacity)
            }
        }
    }
}

//MARK: - PreviewProvider

struct SimpleIterationSolutionView_Previews: PreviewProvider {
    static let equation = "x^2+10"
    static var previews: some View {
        SimpleIterationSolutionView(
            viewModel: EquationSolutionViewModel(
                equation: equation,
                equationExpression: equation.expression,
                solvingMethod: .simpleIterations
            )
        )
    }
}
