//
//  NewtonIteration.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import SwiftUI

struct NewtonIteration: View {
    let iterationInfo: NewtonIterationInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Iteration \(iterationInfo.iteration)")
                .font(.title2)
                .fontWeight(.semibold)
                .underline()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("F'(x) =")
                    Text("\(iterationInfo.derivative)")
                        .foregroundColor(.pink)
                }
                
                if let secondDerivative = iterationInfo.secondDerivative {
                    HStack {
                        Text("F''(x) =")
                        Text("\(secondDerivative)")
                            .foregroundColor(.pink)
                    }
                }
            }
            .font(.headline)
            
            Text("X = \(iterationInfo.x)")
                .font(.headline)
                .foregroundColor(.pink)
        }
        .padding()
    }
}

struct NewtonIteration_Previews: PreviewProvider {
    static var previews: some View {
        NewtonIteration(
            iterationInfo: .init(
                iteration: 1,
                derivative: -34,
                secondDerivative: 48,
                x: -2
            )
        )
    }
}
