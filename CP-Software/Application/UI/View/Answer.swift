//
//  Answer.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import SwiftUI

struct Answer: View {
    let answer: Double
    let functionValue: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("X = \(answer)")
            Text("F(x) = \(functionValue)")
        }
        .padding(.vertical)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundColor(.pink)
    }
}

struct Answer_Previews: PreviewProvider {
    static var previews: some View {
        Answer(answer: 1.14562, functionValue: 0.0452)
    }
}
