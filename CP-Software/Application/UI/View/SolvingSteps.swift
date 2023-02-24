//
//  SolvingSteps.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 24.02.2023.
//

import SwiftUI

struct SolvingSteps: View {
    let solvingMethod: EquationSolvingMethod
    let iterationsInfo: [Any]
    
    var body: some View {
        switch solvingMethod {
        case .dichotomy:
            if let dichotomyIterationsInfo = iterationsInfo as? [DichotomyIterationInfo] {
                ForEach(dichotomyIterationsInfo, id: \.iteration) { info in
                    DichotomyIteration(iterationInfo: info)
                }
            }
        case .simpleIterations:
            if let simpleIterationsInfo = iterationsInfo as? [SimpleIterationInfo] {
                ForEach(simpleIterationsInfo, id: \.iteration) { info in
                    SimpleIteration(iterationInfo: info)
                }
            }
        case .newton:
            if let newtonIterationsInfo = iterationsInfo as? [NewtonIterationInfo] {
                ForEach(newtonIterationsInfo, id: \.iteration) { info in
                    NewtonIteration(iterationInfo: info)
                }
            }
        }
    }
}
