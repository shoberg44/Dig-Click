//
//  SettingsViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 4/28/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var devCodeInput: UITextField!
    @IBOutlet weak var randSeedOutlet: UIButton!
    @IBOutlet weak var customSeedTextField: UITextField!
    @IBOutlet weak var layer1DevHorStack: UIStackView!
    @IBOutlet weak var layer2DevHorStack: UIStackView!
    var devBool:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSeedTextField.text = "\(Public.seed)"
        randSeedOutlet.backgroundColor = .clear
        if Public.randomSeed{
            randSeedOutlet.backgroundColor = .green
        }
    }
    
    @IBAction func itemTestSet(_ sender: UIButton) {
        var newItems: [Drop] = []
        var UUIDTrack = 0
        for _ in 1...5{
            newItems.append(Drop(type: .coal, UUID: UUIDTrack))
            UUIDTrack += 1
        }
        for _ in 1...5{
            newItems.append(Drop(type: .copper, UUID: UUIDTrack))
            UUIDTrack += 1
        }
        for _ in 1...5{
            newItems.append(Drop(type: .diamond, UUID: UUIDTrack))
            UUIDTrack += 1
        }
        for _ in 1...5{
            newItems.append(Drop(type: .pebble, UUID: UUIDTrack))
            UUIDTrack += 1
        }
        for _ in 1...5{
            newItems.append(Drop(type: .rarity, UUID: UUIDTrack))
            UUIDTrack += 1
        }
        for _ in 1...5{
            newItems.append(Drop(type: .diamond, UUID: UUIDTrack))
            UUIDTrack += 1
        }
//        for i in 0..<newItems.count{
//            print(newItems[i].UUID)
//        }
        Public.inventory = newItems
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
    @IBAction func devCodeApply(_ sender: UIButton) {
        if devCodeInput.text == "menu"{
            devBool.toggle()
        }
        if devBool{
            layer1DevHorStack.isHidden.toggle()
            layer2DevHorStack.isHidden.toggle()
        }
    }
    func save(){
        print("saving items")
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.inventory)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "inventory")

        } catch {
            print("Unable to Encode inventory (\(error))")
        }
    }
}
