//
//  UIApplication + Ext.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 22.02.2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
