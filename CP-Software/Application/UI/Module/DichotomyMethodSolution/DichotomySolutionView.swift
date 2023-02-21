//
//  DichotomySolutionView.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 21.02.2023.
//

import SwiftUI

struct DichotomySolutionView: View {
    @ObservedObject var viewModel: DichotomySolutionViewModel
    @State private var isSolveButtonHidden = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 20) {
                    ScrollView(.horizontal) {
                        Text(viewModel.equation)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.pink)
                            .padding(.vertical)
                    }
                    
                    Stepper(value: $viewModel.epsilon, in: 0.001...1, step: 0.001) {
                        Text("Accuracy ε = " + String(format: "%.3f", viewModel.epsilon))
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Search from")
                        rangeTextField(
                            title: "Low",
                            text: $viewModel.lowSearchRangeText
                        )
                        
                        Text("to")
                        rangeTextField(
                            title: "High",
                            text: $viewModel.highSearchRangeText
                        )
                    }
                    .font(.headline)
                }
            }
            
            if !viewModel.interimResults.isEmpty {
                Section {
                    ForEach(viewModel.interimResults, id: \.iteraction) {
                        result in
                        DichotomyIteration(iterationInfo: result)
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        if let answer = viewModel.answer {
                            Text("X = \(answer)")
                            Text("F(x) = \(viewModel.function(x: answer))")
                        } else {
                            Text("No Solution")
                        }
                        Spacer()
                    }
                    .frame(height: 200)
                    .padding()
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                }
            }
            
            
            
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Dichotomy Method")
        .overlay {
            VStack {
                Spacer()
                ZStack {
                    if viewModel.isSolveButtonEnable {
                        solveButton
                            .padding()
                    }
                }
                .animation(.default, value: viewModel.isSolveButtonEnable)
                .transition(.opacity)
            }
        }
    }
    
    private var solveButton: some View {
        Button {
            viewModel.calculate()
        } label: {
            Text("Solve")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.pink)
                }
            
        }
        .tint(.white)
    }
    
    private func rangeTextField(title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .foregroundColor(.pink)
            .multilineTextAlignment(.center)
            .frame(width: 60)
            .tint(.pink)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numbersAndPunctuation)
    }
}

struct DichotomyMethodSolutionView_Previews: PreviewProvider {
    
    static var previews: some View {
        DichotomySolutionView(viewModel: DichotomySolutionViewModel(equation: "x^2+10", equationExpression: "x**2+10".expression))
    }
}
