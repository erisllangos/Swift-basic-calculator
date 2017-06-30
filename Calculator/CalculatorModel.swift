//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Eris  Llangos on 6/29/17.
//  Copyright © 2017 Eris  Llangos. All rights reserved.
//

import Foundation

func changeSign(op: Double) -> Double {
    return -op
}

func multiply (op1: Double, op2: Double) -> Double {
    return op1 * op2
}

func add (op1: Double, op2: Double) -> Double {
    return op1 + op2
}

func subtract (op1: Double, op2: Double) -> Double {
    return op1 - op2
}

func divide (op1: Double, op2: Double) -> Double {
    return op1 / op2
}
struct CalculatorModel{
    
    private enum operationsTypes {
        case const(Double)
        case unaryOps((Double)->Double)
        case binaryOps((Double, Double)->Double)
        case equals
    }
    
    
    
    private var operations: Dictionary<String, operationsTypes> =
    [
        "π" : operationsTypes.const(Double.pi),
        "e" : operationsTypes.const(M_E),
        "√" : operationsTypes.unaryOps(sqrt),
        "cos" : operationsTypes.unaryOps(cos),
        "sin" : operationsTypes.unaryOps(sin),
        "tan" : operationsTypes.unaryOps(tan),
        "±" : operationsTypes.unaryOps(changeSign),
        "+" : operationsTypes.binaryOps(add),
        "-" : operationsTypes.binaryOps(subtract),
        "×" : operationsTypes.binaryOps(multiply),
        "÷" : operationsTypes.binaryOps(divide),
        "=" : operationsTypes.equals
    ]
    
    var result : Double? {
        
        get{
            return accumulator
        }
    }
    private var accumulator : Double?
    
    mutating func performOperation (_ symbol: String){
        if let operation = operations[symbol] {
            switch operation{
            case .const(let val):
                accumulator = val
                
            case .unaryOps(let f):
                if (accumulator != nil){
                    accumulator = f(accumulator!)
                }
            case .binaryOps(let f):
                if accumulator != nil{
                    operationPerformance = pendingBinary(function: f, firstOp: accumulator!)
                    accumulator = nil
                }
                
            case .equals:
               opEqual()
                
            default:
                break
                
            }
        }
        
    }
    mutating private func opEqual (){
        if operationPerformance != nil && accumulator != nil{
            accumulator = operationPerformance!.perform(with: accumulator!)
            operationPerformance = nil
        }
    }
    private struct pendingBinary{
        let function: (Double, Double)->Double
        let firstOp : Double
        
        func perform (with secondOp: Double)->Double{
            return function(firstOp, secondOp)
        }
    }
    
    private var operationPerformance: pendingBinary?
    
    mutating func setOperand (_ operand: Double){
        accumulator = operand
    }
};
