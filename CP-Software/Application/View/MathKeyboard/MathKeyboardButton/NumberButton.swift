//
//  NumberButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct NumberButton: View {
    let number: Int
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                
                Text(String(number))
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.primary)
            }
        }
        .tint(Color(.secondarySystemBackground))
    }
}

struct NumberButton_Previews: PreviewProvider {
    static var previews: some View {
        NumberButton(number: 1)
    }
}
