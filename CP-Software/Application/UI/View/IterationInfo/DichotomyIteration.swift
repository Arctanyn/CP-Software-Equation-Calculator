//
//  DichotomyIteration.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 21.02.2023.
//

import SwiftUI

struct DichotomyIteration: View {
    let iterationInfo: DichotomyIterationInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Iteration \(iterationInfo.iteration)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .underline()
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("a = \(iterationInfo.a)")
                    Text("b = \(iterationInfo.b)")
                    Text("X ∈ [\(iterationInfo.a); \(iterationInfo.b)]")
                }
                
                Text("X = \(iterationInfo.x)")
                    .foregroundColor(.pink)
                    .fontWeight(.bold)
            }
            .font(.headline)
        }
        .padding()
    }
}

struct DichotomyIterationView_Previews: PreviewProvider {
    static var previews: some View {
        DichotomyIteration(
            iterationInfo: .init(
                iteration: 1,
                a: 2,
                b: 0,
                x: 1.40556
            )
        )
    }
}
