//
//  SettingsViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 4/28/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var randSeedOutlet: UIButton!
    @IBOutlet weak var customSeedTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSeedTextField.text = "\(Public.seed)"
        randSeedOutlet.backgroundColor = .clear
        print(Public.randomSeed)
        if Public.randomSeed{
            randSeedOutlet.backgroundColor = .green
        }
    }
    
    @IBAction func pickaxeButton(_ sender: UIButton) {
        Public.pickaxe = Pickaxe(type: .silicon)
        Public.purchasedPickaxes.append(Pickaxe(type: .silicon))
    }
    @IBAction func moneyButton(_ sender: UIButton) {
        Public.money += 99999
    }
    @IBAction func randomSeedButton(_ sender: UIButton) {
        switch Public.randomSeed {
        case true:
            sender.backgroundColor = .clear
            Public.randomSeed = false
        case false:
            sender.backgroundColor = .green
            Public.randomSeed = true
        }
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
        customSeedTextField.text = "\(numbers)"
        Public.seed = UInt64(numbers)
        if Public.randomSeed{
            randSeedOutlet.backgroundColor = .clear
            Public.randomSeed = false
        }
    }
}
