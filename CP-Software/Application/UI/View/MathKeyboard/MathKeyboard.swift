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
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    deleteButton
                }
                
                HStack(spacing: 15) {
                    ForEach(MathKeyboardSection.allCases, id: \.self) { section in
                        MathKeyboardSectionButton(keyboardSection: section)
                            .environmentObject(viewModel)
                    }
                }
                .frame(height: geometry.size.height * 0.05)
                .padding(.vertical)
                .padding(.horizontal, 5)
                
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
                    TriginometryPad()
                case .expAndLogarithms:
                    GeometryReader { proxy in
                        HStack(alignment: .top, spacing: 2) {
                            AdvancedMathOperationButton(mathOperation: .e)
                            AdvancedMathOperationButton(mathOperation: .exp)
                            AdvancedMathOperationButton(mathOperation: .log2)
                            AdvancedMathOperationButton(mathOperation: .lg)
                            AdvancedMathOperationButton(mathOperation: .ln)
                        }
                        .frame(height: proxy.size.height / 4)
                    }
                    
                }
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
