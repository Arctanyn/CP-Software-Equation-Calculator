//
//  EquationInput.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 16.02.2023.
//

import SwiftUI

struct EquationInput: View {
    @State private var text = String()
    
    init() {
        UITextField.appearance().inputView = UIView()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Type an equation...", text: $text)
                    .font(.system(size: 22))
                    .padding()
                
                Spacer()
                
                MathKeyboard()
                    .padding(.bottom)
            }
            .navigationTitle("Calculator")
        }
    }
}

struct EquationInput_Previews: PreviewProvider {
    static var previews: some View {
        EquationInput()
    }
}
