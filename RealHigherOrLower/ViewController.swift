//
//  ViewController.swift
//  RealHigherOrLower
//
//  Created by Carter Struck on 5/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    // Counts money
    var MoneyCounter:Int = 0
    
    // Sets up Active Clicker Formula
    let ActiveClickerSlope:Int = 3
    let ActiveClickerBase:Int = 5
    var ActiveClickerLevel:Int = 1
    var ActiveClickerCost:Double = 8
    
    var ActiveMoneyMaking:Int = 1
    
    
    // Sets up Passive Clicker Formula
    let PassiveClickerConstant:Double = 0.5
    let PassiveClickerExponent:Double = 1.3
    let PassiveClickerBase:Double = 500
    var PassiveClickerLevel:Int = 1
    var PassiveClickerCost:Double = 500
    
    var PassiveMoneyMaking: Double = 1.0
    
    @IBOutlet weak var MoneyAmountText: UITextField!
    

    @IBOutlet weak var ActiveClickerButton: UIButton!
    
    
    @IBOutlet weak var MainButton: UIButton!
    
    
    @IBOutlet weak var AmountPerClickTracker: UILabel!
    
    
    @IBOutlet weak var PassiveClickerButton: UIButton!
    
    
    @IBOutlet weak var BoochaPerSecondCounter: UILabel!
    
    // SubmitButton tenMoneyButton PassiveMoney MoneyAmount
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constantGoing()
    }

    // N * M + B
    // N = "Level"
    func calculateActiveClickerCost() -> Double{
        return Double(ActiveClickerLevel * ActiveClickerSlope + ActiveClickerBase)
    }
    // C * x^p + B
    func calculatePassiveClickerCost() -> Double{
        return PassiveClickerConstant * pow(Double(PassiveClickerLevel), PassiveClickerExponent) + PassiveClickerBase
    }
    
    
    @IBAction func BuyNextActive(_ sender: Any) {
        
        if Double(MoneyCounter) >= ActiveClickerCost {
            // takes money for cost if you have enough
            MoneyCounter -= Int(ActiveClickerCost)
            
            
            ActiveMoneyMaking += 1
            
            // Moves on to next level
            ActiveClickerLevel += 1
            
            // finds new cost and sets as title
            ActiveClickerCost = calculateActiveClickerCost()
            ActiveClickerButton.setTitle("$\(ActiveClickerCost)", for: .normal)
            AmountPerClickTracker.text = "\(ActiveMoneyMaking)"
        } // if
    }// BuyNextActive
    
    
    @IBAction func BuyNextPassive(_ sender: Any) {
        if Double(MoneyCounter) >= PassiveClickerCost{
            
            // Takes money
            MoneyCounter -= Int(PassiveClickerCost)
            
            PassiveMoneyMaking += 1
            
            PassiveClickerLevel += 1
            
            PassiveClickerCost = calculatePassiveClickerCost()
            
            PassiveClickerButton.setTitle("$\(Int(PassiveClickerCost))", for: .normal)
            UpdateText()
            // Does not set bps here does it in text
        }
    }
    
    
    @IBAction func IncrementMoney(_ sender: Any) {
        // Increments main money amount and updates text
        MoneyCounter += ActiveMoneyMaking
        UpdateText()
    } // IncrementMoney
    
    
    //Primay function to repeat the money update
    func UpdateText (){
        MoneyAmountText.text = "\(MoneyCounter)"
        BoochaPerSecondCounter.text = "BPS: \(Int(PassiveMoneyMaking))"
    }// Updatetext
    
    // Main timer for money
    // Timing done with MoneyTimer Duble
    // To be decremented slowly
    func constantGoing() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.MoneyCounter += Int(self!.PassiveMoneyMaking)
            self?.UpdateText()
        }// Timer
    }// ConstantGoing
    
}// End of Class
