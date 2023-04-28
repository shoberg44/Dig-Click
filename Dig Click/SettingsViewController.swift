//
//  SettingsViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 4/28/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var customSeedTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearProgressButton(_ sender: UIButton) {
        Public.money = 0
        Public.pickaxe = Pickaxe(type: .wood)
        Public.purchasedPickaxes = [Pickaxe(type: .wood)]
        Public.inventory = []
        UserDefaults.standard.removeObject(forKey: "inventory")
        UserDefaults.standard.removeObject(forKey: "pickaxe")
        UserDefaults.standard.removeObject(forKey: "pickaxes")
        UserDefaults.standard.removeObject(forKey: "money")
    }
    @IBAction func applySeedButton(_ sender: UIButton) {
        let numbers = Int(customSeedTextField.text!) ?? 0
        Public.seed = UInt64(numbers)
    }
}
