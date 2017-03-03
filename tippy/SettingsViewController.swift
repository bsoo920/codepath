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
    var tipPercs = [0.18,0.20,0.25]
    var yTaxRate: CGFloat = 0.0
    var yShowSliders: CGFloat = 0.0
    var yHideSliders: CGFloat = 0.0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let myVC = storyboard?.instantiateViewControllerWithIdentifier("SecondVC") as! SecondVC
//        myVC.stringPassed = myLabel.text!
//        navigationController?.pushViewController(myVC, animated: true)
//
//        let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as! ViewController
//        mainVC.
        
        //get reference positions
        yTaxRate = taxRateView.center.y
        yShowSliders = blockView.center.y
        yHideSliders = yShowSliders + blockView.frame.height
        
        //apply toggle state for taxControl
        applyToggle()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func taxToggle(_ sender: Any) {
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
        tipPercs[i] = Double(SL.value) * maxPerc
        
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































