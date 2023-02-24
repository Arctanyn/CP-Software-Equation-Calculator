//
//  SolutionSearchParametersRepresentation.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 23.02.2023.
//

import SwiftUI

struct SolutionSearchParametersRepresentation: View {
    enum TextFieldInFocus {
        case low
        case high
    }
    
    @EnvironmentObject private var viewModel: EquationSolutionViewModel
    @FocusState private var textFieldFocus: TextFieldInFocus?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView(.horizontal) {
                HStack {
                    Text("F(x) =")
                    Text(viewModel.equation)
                        .foregroundColor(.pink)
                }
                .font(.title2)
                .fontWeight(.medium)
                .padding(.vertical)
            }
            
            HStack {
                Text("Accuracy ε = ")
                valueTextField(title: "Num", text: $viewModel.epsilonValueText)
            }
            .font(.headline)

            HStack {
                Text("Search from")
                valueTextField(
                    title: "Low",
                    text: $viewModel.lowSearchRangeText
                )
                .focused($textFieldFocus, equals: .low)
                .onSubmit {
                    textFieldFocus = .high
                }
                
                Text("to")
                valueTextField(
                    title: "High",
                    text: $viewModel.highSearchRangeText
                )
                .focused($textFieldFocus, equals: .high)
            }
            .font(.headline)
        }
    }
}

//MARK: - Private

private extension SolutionSearchParametersRepresentation {
    func valueTextField(title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .foregroundColor(.pink)
            .multilineTextAlignment(.center)
            .frame(width: 80)
            .tint(.pink)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numbersAndPunctuation)
    }
    
}

struct SolutionSearchParametersRepresentation_Previews: PreviewProvider {
    static var previews: some View {
        SolutionSearchParametersRepresentation()
            .environmentObject(
                EquationSolutionViewModel(
                    equation: "X",
                    equationExpression: "X".expression,
                    solvingMethod: .dichotomy
                )
            )
    }
}
