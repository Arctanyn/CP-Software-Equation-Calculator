//
//  MathKeyboardSectionButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 01.03.2023.
//

import SwiftUI

struct MathKeyboardSectionButton: View {
    @EnvironmentObject private var viewModel: EquationInputViewModel
    let keyboardSection: MathKeyboardSection
    
    var isCurrentSection: Bool {
        keyboardSection == viewModel.currentKeyboardSection
    }
    
    var body: some View {
        ZStack {
            if isCurrentSection {
                Capsule(style: .continuous)
            } else {
                Capsule(style: .continuous)
                    .stroke(lineWidth: 2)
            }
            
            buttonTitle
                .font(.headline)
                .foregroundColor(isCurrentSection ? Color(.systemBackground) : .primary)
                .padding(5)
                .padding(.horizontal)
            
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.1)) {
                viewModel.currentKeyboardSection = keyboardSection
            }
        }
    }
    
    private var buttonTitle: some View {
        switch keyboardSection {
        case .numbersAndGeneralOperations:
            return VStack {
                Text("+  -")
                Text("×  ÷")
            }
        case .trigonometry:
            return VStack {
                Text("sin  cos")
                Text("tan  cot")
            }
        case .expAndLogarithms:
            return VStack {
                Text("e")
                Text("log  ln")
            }
        }
    }
    
}

struct MathOperationsBlock_Previews: PreviewProvider {
    static var previews: some View {
        MathKeyboardSectionButton(keyboardSection: .numbersAndGeneralOperations)
            .environmentObject(EquationInputViewModel())
    }
}
