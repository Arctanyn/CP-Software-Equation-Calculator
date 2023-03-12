//
//  SimpleIteration.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import SwiftUI

struct SimpleIteration: View {
    let iterationInfo: SimpleIterationInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Iteration \(iterationInfo.iteration)")
                .font(.title2)
                .fontWeight(.semibold)
                .underline()
            
            if let m = iterationInfo.m,
               let functionDerivative = iterationInfo.functionDerivative {
                VStack(alignment: .leading) {
                    HStack {
                        Text("F'(x) =")
                        Text("\(functionDerivative)")
                            .foregroundColor(.pink)
                    }
                    
                    HStack {
                        Text("M =")
                        Text("\(m)")
                            .foregroundColor(.pink)
                    }
                }
                .font(.headline)
            }
            
            Text("X = \(iterationInfo.x)")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.pink)
        }
        .padding()
    }
}

struct SimpleIteration_Previews: PreviewProvider {
    static var previews: some View {
        SimpleIteration(iterationInfo:
            .init(iteration: 1, x: 1, m: 30.5, functionDerivative: 4)
        )
    }
}
