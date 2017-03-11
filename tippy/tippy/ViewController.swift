//
//  ViewController.swift
//  tippy
//
//  Created by Soo, Bright on 2/25/17.
//  Copyright © 2017 Bright Soo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipNameLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet      var tipControl: UISegmentedControl!
    @IBOutlet weak var taxNoteLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var preTax1or0 = 0
    var taxRate = 0.0875
    var tipPercentages = [0.15,0.18,0.20]
    var lastPickedPerc = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        preTax1or0 = defaults.integer(forKey: "preTax1or0")
        taxRate    = defaults.double (forKey: "taxRate")
        
        if (defaults.array(forKey: "tipPercentages") != nil) {
            tipPercentages = defaults.array(forKey: "tipPercentages") as! [Double]
        }
        
        lastPickedPerc = defaults.integer(forKey: "lastPickedPerc")
        
        //updateLabels(0, total: 0)
        calculateTip( NSNull.self)
        updateTipControl()
        billField.becomeFirstResponder()
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateLabels(0, total: 0)
//        billField.becomeFirstResponder()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {

        let bill = Double(billField.text!) ?? 0
        let tip = bill / (1 + Double(preTax1or0) * taxRate)
                       * tipPercentages[ tipControl.selectedSegmentIndex]
        let total = bill + tip

        updateLabels(tip, total: total)
    }
    
    func updateLabels(_ tip: Double, total: Double) {

        if (preTax1or0==0) {
            taxNoteLabel.text = "(after tax)"
        } else {
            taxNoteLabel.text = "(before " + String(format: "%.2f%%", taxRate*100) + " tax)"
        }
        
        let locale = Locale.current
        let strFormat = locale.currencySymbol!+"%.2f"
        
        tipLabel.text = String(format: strFormat, tip)
        totalLabel.text = String(format: strFormat, total)
//        tipControl.selectedSegmentIndex = lastPickedPerc
    }

    func updateTipControl() {
        for k in 0...2 {
            tipControl.setTitle(String(format: "%.0f%%", 100*tipPercentages[k]), forSegmentAt: k)
        }
        tipControl.selectedSegmentIndex = lastPickedPerc
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //defaults.set(preTax1or0, forKey: "preTax1or0")
        defaults.set(taxRate, forKey: "taxRate")
        defaults.set(tipPercentages, forKey: "tipPercentages")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "lastPickedPerc")
        defaults.synchronize()
    }
    
}




















