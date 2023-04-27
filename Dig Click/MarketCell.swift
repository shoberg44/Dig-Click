//
//  marketCell.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 3/15/23.
//
import UIKit
import Foundation
class MarketCell : UICollectionViewCell{
    
    @IBOutlet weak var marketIcon: UIImageView!
    @IBOutlet weak var marketTitle: UILabel!
    @IBOutlet weak var marketValue: UILabel!
    var isSelectedC = false
    func configure(name: String, value: Double, icon: String){
        marketTitle.text = name
        marketIcon.image = UIImage(named: icon)
        marketValue.text = moneyFormat(value: value)
    }
    func moneyFormat(value: Double)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: value as NSNumber) {
            return "\(formattedTipAmount)"
        }
        else{
            return "error"
        }
    }
}
