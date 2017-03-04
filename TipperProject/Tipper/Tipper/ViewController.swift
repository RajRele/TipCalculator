//
//  ViewController.swift
//  Tipper
//
//  Created by Bharat on 3/2/17.
//  Copyright © 2017 Bharat. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

class ViewController: UIViewController {

    @IBOutlet weak var billValue: UITextField!
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totolValue: UILabel!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    @IBOutlet weak var viewToAnimate: UIView!
    
    //@IBOutlet weak var settingsButtion: UIBarButtonItem!
    @IBOutlet weak var appSettings: UIBarButtonItem!
    
    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let defaults = UserDefaults.standard
        //defaults.set(0, forKey: "tipIndex")
        //defaults.synchronize()
        
        view.backgroundColor = UIColor.yellow
        
        tipValue.text=getCurrency()+"0.00"
        totolValue.text=getCurrency()+"0.00"
        viewToAnimate.alpha=0
        billValue.frame=billValue.frame.offsetBy(dx: 0.0, dy: 150.0)
        viewToAnimate.frame=viewToAnimate.frame.offsetBy(dx: 0.0, dy: 300.0)
        
        billValue.becomeFirstResponder()
        
       // self.settingsButtion.title = NSString(string: "\u{2699}\u{0000FE0E}") as String
        //if let font = UIFont(name: "Helvetica", size: 24.0){
         //   self.settingsButtion.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
        //}
        
        self.appSettings.title = NSString(string: "\u{2699}\u{0000FE0E}") as String
        if let font = UIFont(name: "Helvetica", size: 24.0){
           self.appSettings.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func getCurrency() -> String {
        let locale = Locale.current
        return (locale as NSLocale).object(forKey: NSLocale.Key.currencySymbol) as! String
        
    }
    
    @IBAction func calcTip(_ sender: Any) {
        
        let tipPercentages = [0.15, 0.25, 0.30]
        
        let bill = Double(billValue.text!) ?? 0
        let tip = bill * tipPercentages[tipPercent.selectedSegmentIndex]
        let total = bill + tip
        
        
        if (bill>0) {
            if (viewToAnimate.alpha==0) {
                 self.viewToAnimate.alpha=1
                UIView.animate(withDuration: 0.3, animations: {
                  self.billValue.frame=self.billValue.frame.offsetBy(dx: 0.0, dy: -150.0)
                    self.viewToAnimate.frame=self.viewToAnimate.frame.offsetBy(dx: 0.0, dy: -300.0)
                                  })
            }
        } else {
            if (viewToAnimate.alpha==1) {
                self.viewToAnimate.alpha=0
                billValue.placeholder=getCurrency()
                UIView.animate(withDuration: 0.3, animations: {
                    self.billValue.frame=self.billValue.frame.offsetBy(dx: 0.0, dy: 150.0)
                self.viewToAnimate.frame=self.viewToAnimate.frame.offsetBy(dx: 0.0, dy: 300.0)
                   
                })
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        tipValue.text = numberFormatter.string(from: NSNumber(value: tip)) //String(format: "$%.2f", tip)
        totolValue.text = numberFormatter.string(from: NSNumber(value: total))//String(format: "$%.2f", total)
        saveBillValue()
        
    }
    
    func saveBillValue() {
        defaults.set(billValue.text, forKey: "billMemory")
        defaults.set(Date(), forKey: "billDate")
        defaults.synchronize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveBillValue()
        //print("view will disappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tipPercent.selectedSegmentIndex = defaults.integer(forKey: "tipIndex")
        billValue.placeholder = getCurrency()
        
        let savedDate = defaults.object(forKey: "billDate") as? Date
        if (savedDate != nil && integer_t(Date().timeIntervalSince(savedDate!)) < 600) {
            billValue.text = UserDefaults.standard.object(forKey: "billMemory") as? String
        }
        
        self.calcTip(self)
        
        //print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //print("view did disappear")
    }
    
    //@IBAction func goToSettings(_ sender: Any) {
      //  UIApplication.shared.openURL(URL(string:"App-Prefs:root=General")!)
    //}
}

