//
//  NumbersPad.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct NumbersPad: View {
    var body: some View {
        VStack(spacing: 2) {
            numberButtons(withNumbers: 7..<10)
            numberButtons(withNumbers: 4..<7)
            
            VStack(spacing: 2) {
                numberButtons(withNumbers: 1..<4)
                
                HStack(spacing: 2) {
                    NumberButton(number: 0)
                        .frame(width: 132, height: 65)
                    
                    AuxiliaryMathOperationButton(mathOperation: .dot)
                        .frame(width: 65, height: 65)
                }
            }
        }
    }
    
    private func numberButtons(withNumbers numbers: Range<Int>) -> some View {
        HStack(spacing: 2) {
            ForEach(numbers, id: \.self) {
                NumberButton(number: $0)
                    .frame(width: 65, height: 65)
            }
        }
    }
}

struct NumbersPad_Previews: PreviewProvider {
    static var previews: some View {
        NumbersPad()
    }
}
