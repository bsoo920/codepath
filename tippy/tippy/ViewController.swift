//
//  ViewController.swift
//  tippy
//
//  Created by Soo, Bright on 2/25/17.
//  Copyright © 2017 Bright Soo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet      var tipControl: UISegmentedControl!

    //taxRate variable simulates having read the tax rate from Settings.
    //An "after-tax" setting would be represented by a zero tax rate.
    let taxRate = 0.0875
    
    
 /* -- attempted code to give SettingsViewController access to tipControl here --
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels(0, total: 0)
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let tipPercentages = [0.18,0.20,0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill / (1+taxRate) * tipPercentages[ tipControl.selectedSegmentIndex]
        let total = bill + tip


        updateLabels(tip, total: total)
    }
    
    func updateLabels(_ tip: Double, total: Double) {

        let locale = Locale.current
        let strFormat = locale.currencySymbol!+"%.2f"
        
        tipLabel.text = String(format: strFormat, tip)
        totalLabel.text = String(format: strFormat, total)
    }

    
    
    
    
}

