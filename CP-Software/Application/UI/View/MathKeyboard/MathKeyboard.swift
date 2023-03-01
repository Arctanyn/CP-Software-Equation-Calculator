//
//  MathKeyboard.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct MathKeyboard: View {
    @EnvironmentObject private var viewModel: EquationInputViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                deleteButton
            }
            
            HStack {
                ForEach(MathKeyboardSection.allCases, id: \.self) { section in
                    MathKeyboardSectionButton(keyboardSection: section)
                        .environmentObject(viewModel)
                }
            }
            .frame(height: 40)
            .padding()
            
            switch viewModel.currentKeyboardSection {
            case .numbersAndGeneralOperations:
                GeometryReader { proxy in
                    HStack(alignment: .top, spacing: 2) {
                        VStack(spacing: 2) {
                            AdvancedMathOperationButton(mathOperation: .pow)
                            AdvancedMathOperationButton(mathOperation: .sqrt)
                            AuxiliaryMathOperationButton(mathOperation: .roundBracket)
                            AuxiliaryMathOperationButton(mathOperation: .x)
                        }
                        
                        NumbersPad()
                            .frame(width: proxy.size.width * 2 / 3)
                        
                        BasicMathOperationsPad()
                    }
                }
            case .trigonometry:
                HStack(spacing: 2) {
                    VStack(spacing: 2) {
                        AdvancedMathOperationButton(mathOperation: .sin)
                        AdvancedMathOperationButton(mathOperation: .asin)
                        AdvancedMathOperationButton(mathOperation: .sinh)
                        AdvancedMathOperationButton(mathOperation: .asinh)
                    }
                    
                    VStack(spacing: 2) {
                        AdvancedMathOperationButton(mathOperation: .cos)
                        AdvancedMathOperationButton(mathOperation: .acos)
                        AdvancedMathOperationButton(mathOperation: .cosh)
                        AdvancedMathOperationButton(mathOperation: .acosh)
                    }
                    
                    VStack(spacing: 2) {
                        AdvancedMathOperationButton(mathOperation: .tan)
                        AdvancedMathOperationButton(mathOperation: .atan)
                        AdvancedMathOperationButton(mathOperation: .tanh)
                        AdvancedMathOperationButton(mathOperation: .atanh)
                    }
                    
                    VStack(spacing: 2) {
                        AdvancedMathOperationButton(mathOperation: .cot)
                        AdvancedMathOperationButton(mathOperation: .acot)
                        AdvancedMathOperationButton(mathOperation: .coth)
                        AdvancedMathOperationButton(mathOperation: .acoth)
                    }

                }
            case .expAndLogarithms:
                EmptyView()
            }
        }
    }
}

//MARK: - Private

private extension MathKeyboard {
    var deleteButton: some View {
        Button {
            viewModel.removeLastOperation()
        } label: {
            Image(systemName: "delete.left")
                .font(.largeTitle)
                .padding()
        }
        .tint(.primary)
        .disabled(viewModel.isEquationEmpty)
    }
}

struct MathKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        MathKeyboard()
            .environmentObject(EquationInputViewModel())
    }
}
