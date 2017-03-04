//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Bharat on 3/3/17.
//  Copyright © 2017 Bharat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

       // let defaults = UserDefaults.standard
        let tippedValue = defaults.object(forKey: "tipIndex")
        tipPercent.selectedSegmentIndex = tippedValue as! Int
        // Do any additional setup after loading the view.
    }
    @IBAction func onChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercent.selectedSegmentIndex, forKey: "tipIndex")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
