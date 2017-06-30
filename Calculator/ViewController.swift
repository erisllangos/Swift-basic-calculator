//
//  ViewController.swift
//  Calculator
//
//  Created by Eris  Llangos on 6/29/17.
//  Copyright © 2017 Eris  Llangos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayLabel: UILabel!
    var typedByUser : Bool = false
    
    @IBAction func PressButton(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if (typedByUser){
            let currentDisplayed = displayLabel.text!
            displayLabel.text = currentDisplayed + digit
        }
        else{
            displayLabel.text = digit
            typedByUser = true
        }
    }
    
    var DisplayOperations : Double{
        get{
            return Double(displayLabel.text!)!
        }
        set{
            displayLabel.text = String(newValue)
        }
    }
    
    private var model = CalculatorModel()
    @IBAction func operations(_ sender: UIButton) {
        if typedByUser {
            model.setOperand(DisplayOperations)
            typedByUser = false
        }
        if let symbol = sender.currentTitle {
            model.performOperation(symbol)
        }
        if let result = model.result{
           DisplayOperations = result
        }
    }
    
}

