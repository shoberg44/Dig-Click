//
//  StoreViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 3/8/23.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var segmentedPickPicker: UISegmentedControl!
    @IBOutlet weak var steelPickView: UIView!
    @IBOutlet weak var silverPickView: UIView!
    @IBOutlet weak var siliconPickView: UIView!
    @IBOutlet weak var diamondPickView: UIView!
    @IBOutlet weak var ironPickView: UIView!
    @IBOutlet weak var woodPickView: UIView!
    var selectedType: pickType = .wood
    var pickPurchasedState = false
    var pickInfoViews: [UIView] = []
    var pickPrices: [String: Double] = ["wood" : 0.00,"silver":10.00,"iron":50.00,"steel":120,"diamond":500,"silicon":1000]
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = .currency
        selectedType = .wood
        pickInfoViews.append(woodPickView)
        pickInfoViews.append(silverPickView)
        pickInfoViews.append(ironPickView)
        pickInfoViews.append(steelPickView)
        pickInfoViews.append(diamondPickView)
        pickInfoViews.append(siliconPickView)
        woodPickView.isHidden = false
        isAlreadyOwned(targetType: .wood)
        if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
            moneyOutlet.text = "\(formattedTipAmount)"
        }
    }
    
    @IBAction func segmentedPickChange(_ sender: UISegmentedControl) {
        for i in pickInfoViews{
            if i.isHidden == false{
                i.isHidden = true
            }
        }
        
        switch segmentedPickPicker.selectedSegmentIndex {
        case 0:
            woodPickView.isHidden = false
            selectedType = .wood
            isAlreadyOwned(targetType: .wood)
        case 1:
            silverPickView.isHidden = false
            selectedType = .silver
            isAlreadyOwned(targetType: .silver)
        case 2:
            ironPickView.isHidden = false
            selectedType = .iron
            isAlreadyOwned(targetType: .iron)
        case 3:
            steelPickView.isHidden = false
            selectedType = .steel
            isAlreadyOwned(targetType: .steel)
        case 4:
            diamondPickView.isHidden = false
            selectedType = .diamond
            isAlreadyOwned(targetType: .diamond)
        case 5:
            siliconPickView.isHidden = false
            selectedType = .silicon
            isAlreadyOwned(targetType: .silicon)
            
        default:
            print("error in pick indexing")
        }
    }
    
    @IBAction func buyButton(_ sender: UIButton) {
        if pickPurchasedState == false && (Public.money >= pickPrices[selectedType.rawValue]!){
            Public.money -= pickPrices[selectedType.rawValue]!
            let newPick = Pickaxe(type: selectedType)
            Public.purchasedPickaxes.append(newPick)
            Public.pickaxe = newPick
            if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
                moneyOutlet.text = "\(formattedTipAmount)"
            }
        }
        else if pickPurchasedState == false{
            costLabel.text = "To Expensive!"
            print("to expensive")
        }
        else{
            for i in Public.purchasedPickaxes{
                if i.type == selectedType{
                    Public.pickaxe = i
                    break
                }
            }
        }
        isAlreadyOwned(targetType: selectedType)
        save()
    }
    func isAlreadyOwned(targetType: pickType){
        costLabel.backgroundColor = UIColor.systemGray6
        if let formattedTipAmount = formatter.string(from: pickPrices[selectedType.rawValue]! as NSNumber) {
            costLabel.text = "\(formattedTipAmount)"
        }
        costLabel.textColor = UIColor.label
        purchaseButton.setTitle("Purchase", for: .normal)
        pickPurchasedState = false
        for i in Public.purchasedPickaxes{
            if i.type == targetType{
                costLabel.text = "Owned"
                costLabel.backgroundColor = UIColor(named: "DigGreen")
                purchaseButton.setTitle("Equip", for: .normal)
                pickPurchasedState = true
                if i.type == Public.pickaxe.type{
                    purchaseButton.setTitle("Equiped", for: .normal)
                }
                break
            }
        }
    }
    func save(){
        print("saved money | purchasedPic | pickaxe")
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.pickaxe)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "pickaxe")

        } catch {
            print("Unable to Encode pickaxe (\(error))")
        }
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.purchasedPickaxes)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "pickaxes")

        } catch {
            print("Unable to Encode Pickaxes (\(error))")
        }
        Public.defaults.set(Public.money, forKey: "money")
    }

    
    


}
