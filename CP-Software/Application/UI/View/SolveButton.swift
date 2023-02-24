//
//  SolveButton.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 23.02.2023.
//

import SwiftUI

struct SolveButton: View {
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
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
}

struct SolveButton_Previews: PreviewProvider {
    static var previews: some View {
        SolveButton()
    }
}
