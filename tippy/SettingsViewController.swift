//
//  SettingsViewController.swift
//  tippy
//
//  Created by Soo, Bright on 2/26/17.
//  Copyright © 2017 Bright Soo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
 /* -- attempted code to give SettingsViewController access to tipControl here --
    //var mainViewController: ViewController!
    
//    var myCustomViewController: SomeViewController = SomeViewController(nibName: nil, bundle: nil)
//    var getThatValue = myCustomViewController.someVariable
    
  */

    @IBOutlet weak var calcLabel: UILabel!
    @IBOutlet weak var taxControl: UISegmentedControl!
    
    @IBOutlet weak var taxRateView: UIView!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var taxField: UITextField!
    @IBOutlet weak var pctLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipSlider0: UISlider!
    @IBOutlet weak var tipSlider1: UISlider!
    @IBOutlet weak var tipSlider2: UISlider!

    @IBOutlet weak var blockView: UIView!

    let numSliders = 2      //starting from 0
    let maxPerc  = 0.40

    var yTaxRate: CGFloat = 0.0
    var yShowSliders: CGFloat = 0.0
    var yHideSliders: CGFloat = 0.0
    
    let defaults = UserDefaults.standard
    var preTax1or0 = 0
    var taxRate = 0.0875
    var tipPercs = [0.18,0.20,0.25]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        preTax1or0 = defaults.integer(forKey: "preTax1or0")
        taxRate    = defaults.double (forKey: "taxRate")
        
        if (defaults.array(forKey: "tipPercentages") != nil) {
            tipPercs = defaults.array(forKey: "tipPercentages") as! [Double]
        }
        
        //get reference positions
        yTaxRate = taxRateView.center.y
        yShowSliders = blockView.center.y
        yHideSliders = yShowSliders + blockView.frame.height
        
        //apply toggle state for taxControl
        var postTax1or0 = 0
        if (preTax1or0 == 1) { postTax1or0=0 } else { postTax1or0=1 }
        taxControl.selectedSegmentIndex = postTax1or0
        
        applyToggle()
        taxField.text = String(format: "%.2f", taxRate * 100)
        
        //rotate and set sliders; set tipControl segment titles.
        var SL = [tipSlider0,tipSlider1,tipSlider2]
        
        for i in 0...numSliders {
            
            SL[i]?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2*3))
            SL[i]?.value = Float(tipPercs[i]/maxPerc)
            tipControl.setTitle(String(format: "%.0f%%", 100*tipPercs[i]), forSegmentAt: i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaults.set(preTax1or0, forKey: "preTax1or0")
        defaults.set( (Double(taxField.text!) ?? 0) / 100, forKey: "taxRate")
        defaults.set(tipPercs, forKey: "tipPercentages")
        defaults.synchronize()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func taxToggle(_ sender: Any) {
        if (taxControl.selectedSegmentIndex == 0) { preTax1or0 = 1 } else { preTax1or0 = 0}
        
        applyToggle()
    }

    func applyToggle() {
        if taxControl.selectedSegmentIndex==0 {
            //pre-tax: enable tax rate.

            UIView.animate(
                withDuration: 0.4,
                animations: ( {
                    self.taxRateView.alpha=1
                    self.taxRateView.center.y = self.yTaxRate

                })
            )
            taxField.isEnabled = true

        } else {
            //after-tax:  disable tax rate.

            UIView.animate(
                withDuration: 0.4,
                animations: ( {
                    self.taxRateView.alpha=0
                    self.taxRateView.center.y = self.taxControl.center.y
                    
                })
            )
            taxField.isEnabled = false
        }
    }

    @IBAction func taxEditBegin(_ sender: Any) {
        UIView.animate(
            withDuration: 0.6,
            animations: ({
                self.blockView.center.y = self.yHideSliders
            })
        )
    }
    
    @IBAction func taxEditEnd(_ sender: Any) { showSliders() }
    @IBAction func onTap     (_ sender: Any) { showSliders() }

    func showSliders() {
        view.endEditing(true)
        
        UIView.animate(
            withDuration: 0.4,
            animations: ({
                self.blockView.center.y = self.yShowSliders
            })
        )
    }


    @IBAction func onUISlider0(_ sender: UISlider) { onSlide(0, SL: tipSlider0 )   }
    @IBAction func onUISlider1(_ sender: UISlider) { onSlide(1, SL: tipSlider1 )   }
    @IBAction func onUISlider2(_ sender: UISlider) { onSlide(2, SL: tipSlider2 )   }


    func onSlide(_ i: Int, SL: UISlider) {

        tipControl.selectedSegmentIndex = i
        var SLarr = [tipSlider0,tipSlider1,tipSlider2]
        tipPercs[i] = round(Double(SL.value) * maxPerc * 100) / 100
        
        //make sure slider0 <= slider1 <= slider2
        if !(tipSlider0.value <= tipSlider1.value && tipSlider1.value <= tipSlider2.value) {
            
            //propagate from active slider to the ones on RIGHT
            if (i+1)<=numSliders {
                for k in (i+1)...numSliders {
                    if tipPercs[k-1] > tipPercs[k] { tipPercs[k]=tipPercs[k-1] }
                }
            }
            
            //propagate from active slider to the ones on LEFT
            if 0<=(i-1) {
                for k in (0...(i-1)).reversed() {
                    if tipPercs[k] > tipPercs[k+1] { tipPercs[k]=tipPercs[k+1] }
                }
            }

        }

        for k in 0...numSliders {
            tipControl.setTitle(String(format: "%.0f%%", 100*tipPercs[k]), forSegmentAt: k)
            if i != k {
                SLarr[k]?.value = Float(tipPercs[k]/maxPerc)
            }
        }
        
    }

}































