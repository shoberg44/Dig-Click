//
//  Pickaxe.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 3/1/23.
//

import Foundation
import UIKit
public enum pickType: String{
    case wood = "wood"
    case iron = "iron"
    case diamond = "diamond"
    case steel = "steel"
    case silver = "silver"
    case silicon = "silicon"
}
class Pickaxe{
    
    static var imageSet: [UIImage] = [UIImage(named: "SteelPick")!,UIImage(named: "SilverPick.png")!,UIImage(named: "DiamondPick.png")!,UIImage(named: "IronPick.png")!]
    var image: UIImage
    var damage: Int = 50
    var spread: Double = 0 //cutoff distance
    var spreadStrength: Double = 4 //lower strength means higher damage
    var resistance: Int = 1 //hits before reset
    var type: pickType = .wood
    
    init(type: pickType) {
        self.type = type
        switch type {
        case .wood:
            damage = 10
            image = Pickaxe.imageSet[0]
            spread = 0
        case .iron:
            damage = 50
            image = Pickaxe.imageSet[3]
            spread = 50
        case .silver:
            image = Pickaxe.imageSet[1]
            damage = 25
        case .diamond:
            damage = 70
            image = Pickaxe.imageSet[2]
            spread = 100
        case .steel:
            damage = 40
            image = Pickaxe.imageSet[0]
            spread = 35
        case .silicon:
            image = Pickaxe.imageSet[0]
            damage = 100
            spread = 250
            
        
        }
    }
    
}
