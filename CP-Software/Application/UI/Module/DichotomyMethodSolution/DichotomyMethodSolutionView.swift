//
//  DichotomyMethodSolutionView.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 21.02.2023.
//

import SwiftUI

struct DichotomyMethodSolutionView: View {
    @ObservedObject var viewModel: EquationSolutionViewModel
    @State private var isSolveButtonHidden = false
    
    var body: some View {
        List {
            Section {
                SolutionSearchParametersRepresentation()
            }
            .environmentObject(viewModel)
            
            if let dichotomyIterations = viewModel.iterationsInfo as? [DichotomyIterationInfo], !dichotomyIterations.isEmpty {
                Section {
                    ForEach(dichotomyIterations, id: \.iteraction) { iteration in
                        DichotomyIteration(iterationInfo: iteration)
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
        .navigationTitle("Dichotomy Method")
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

struct DichotomyMethodSolutionView_Previews: PreviewProvider {
    static let equation = "x^2+10"
    static var previews: some View {
        DichotomyMethodSolutionView(
            viewModel: EquationSolutionViewModel(
                equation: equation,
                equationExpression: equation.expression,
                solvingMethod: .dichotomy
            )
        )
    }
}
