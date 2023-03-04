//
//  NSNumber + Ext.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 01.03.2023.
//

import Foundation

@objc
extension NSNumber {
    func sin() -> NSNumber { Darwin.sin(doubleValue) as NSNumber }
    func asin() -> NSNumber { Darwin.asin(doubleValue) as NSNumber }
    func sinh() -> NSNumber { Darwin.sinh(doubleValue) as NSNumber }
    func asinh() -> NSNumber { Darwin.asinh(doubleValue) as NSNumber }
    
    func cos() -> NSNumber { Darwin.cos(doubleValue) as NSNumber }
    func acos() -> NSNumber { Darwin.acos(doubleValue) as NSNumber }
    func cosh() -> NSNumber { Darwin.cosh(doubleValue) as NSNumber }
    func acosh() -> NSNumber { Darwin.acosh(doubleValue) as NSNumber }
    
    func tan() -> NSNumber { Darwin.tan(doubleValue) as NSNumber }
    func atan() -> NSNumber { Darwin.atan(doubleValue) as NSNumber }
    func tanh() -> NSNumber { Darwin.tanh(doubleValue) as NSNumber }
    func atanh() -> NSNumber { Darwin.atanh(doubleValue) as NSNumber }
    
    func cot() -> NSNumber {
        (Darwin.cos(doubleValue) / Darwin.sin(doubleValue)) as NSNumber
    }
    
    func acot() -> NSNumber {
        if doubleValue > 1.0 {
            return Darwin.atan(1.0 / doubleValue) as NSNumber
        } else if doubleValue < -1.0 {
            return (Double.pi + Darwin.atan(1.0 / doubleValue)) as NSNumber
        } else {
            return (Double.pi / 2 - Darwin.atan(doubleValue)) as NSNumber
        }
    }
    
    func coth() -> NSNumber {
        (1 / Darwin.tanh(doubleValue)) as NSNumber
    }
    
    func acoth() -> NSNumber {
        if doubleValue > 1.0 {
            return Darwin.atanh(1.0 / doubleValue) as NSNumber
        } else if doubleValue < -1.0 {
            return (Double.pi + Darwin.atanh(1.0 / doubleValue)) as NSNumber
        } else {
            return (Double.pi / 2 - Darwin.atanh(doubleValue)) as NSNumber
        }
    }
    
    func log2() -> NSNumber { Darwin.log2(doubleValue) as NSNumber }
}
