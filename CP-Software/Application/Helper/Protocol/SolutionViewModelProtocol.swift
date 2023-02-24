//
//  SolutionViewModelProtocol.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 23.02.2023.
//

import Foundation

protocol SolutionViewModelProtocol: ObservableObject {
    var equation: String { get }
    var epsilon: Double { get }
    var lowSearchRangeText: String { get }
    var highSearchRangeText: String { get }
    var isSolveButtonEnable: Bool { get }
    func solve()
    func function(x: Double) -> Double
}
