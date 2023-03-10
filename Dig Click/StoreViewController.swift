//
//  StoreViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 3/8/23.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var segmentedPickPicker: UISegmentedControl!
    @IBOutlet weak var steelPickView: UIView!
    @IBOutlet weak var silverPickView: UIView!
    @IBOutlet weak var siliconPickView: UIView!
    @IBOutlet weak var diamondPickView: UIView!
    @IBOutlet weak var ironPickView: UIView!
    @IBOutlet weak var woodPickView: UIView!
    var pickPurchasedState = false
    var pickInfoViews: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pickInfoViews.append(woodPickView)
        pickInfoViews.append(silverPickView)
        pickInfoViews.append(ironPickView)
        pickInfoViews.append(steelPickView)
        pickInfoViews.append(diamondPickView)
        pickInfoViews.append(siliconPickView)
        woodPickView.isHidden = false
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
            isAlreadyOwned(targetType: .wood)
        case 1:
            silverPickView.isHidden = false
            isAlreadyOwned(targetType: .silver)
        case 2:
            ironPickView.isHidden = false
            isAlreadyOwned(targetType: .iron)
        case 3:
            steelPickView.isHidden = false
            isAlreadyOwned(targetType: .steel)
        case 4:
            diamondPickView.isHidden = false
            isAlreadyOwned(targetType: .diamond)
        case 5:
            siliconPickView.isHidden = false
            
            isAlreadyOwned(targetType: .silicon)
            
        default:
            print("error in pick indexing")
        }
    }
    func isAlreadyOwned(targetType: pickType){
        for i in Public.purchasedPickaxes{
            if i.type == targetType{
                costLabel.text = "Owned"
                costLabel.backgroundColor = UIColor.green
                purchaseButton.setTitle("Equip", for: .normal)
                pickPurchasedState = true
                break
            }
        }
    }

    
    


}
