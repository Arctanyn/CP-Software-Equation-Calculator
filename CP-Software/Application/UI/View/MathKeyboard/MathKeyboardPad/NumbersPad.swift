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
            numberButtons(withNumbers: 1..<4)
            
            GeometryReader { proxy in
                HStack(spacing: 2) {
                    NumberButton(number: 0)
                        .frame(
                            width: proxy.size.width * 2 / 3
                        )
                    
                    AuxiliaryMathOperationButton(mathOperation: .dot)
                        .frame(
                            width: proxy.size.width * 1 / 3
                        )
                }
            }
        }
    }
    
    private func numberButtons(withNumbers numbers: Range<Int>) -> some View {
        HStack(spacing: 2) {
            ForEach(numbers, id: \.self) {
                NumberButton(number: $0)
            }
        }
    }
}

struct NumbersPad_Previews: PreviewProvider {
    static var previews: some View {
        NumbersPad()
    }
}
