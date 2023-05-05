//
//  InventoryCell.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/14/23.
//
import UIKit
import Foundation
class InventoryCell : UICollectionViewCell{
    var inventoryUUID = 0
    @IBOutlet weak var inventoryIcon: UIImageView!
    @IBOutlet weak var inventoryTitle: UILabel!
    func configure(name: String, value: Double, icon: String, UUID: Int){
        inventoryTitle.text = name
        inventoryIcon.image = UIImage(named: icon)
        inventoryUUID = UUID
    }
}
