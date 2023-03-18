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
    
    static var imageSet: [UIImage] = [UIImage(named: "SteelPick")!,UIImage(named: "SilverPick.png")!,UIImage(named: "DiamondPick.png")!,UIImage(named: "IronPick.png")!,UIImage(named: "WoodPick.png")!,UIImage(named: "SiliconPick.png")!]
    var image: UIImage
    var damage: Double = 50
    var spread: Double = 0 //cutoff distance
    var spreadStrength: Double = 4 //lower strength means higher damage
    var resistance: Int = 1 //hits before reset
    var type: pickType = .wood
    
    init(type: pickType) {
        self.type = type
        switch type {
        case .wood:
            damage = 10
            image = Pickaxe.imageSet[4]
            spread = 50
            spreadStrength = 10
        case .iron:
            damage = 33
            image = Pickaxe.imageSet[3]
            spread = 95
            spreadStrength = 78
        case .silver:
            image = Pickaxe.imageSet[1]
            damage = 18
            spread = 105
            spreadStrength = 60
        case .diamond:
            damage = 70
            image = Pickaxe.imageSet[2]
            spread = 125
            spreadStrength = 69
        case .steel:
            damage = 45 //base direct hit
            image = Pickaxe.imageSet[0]
            spread = 160 //allowed distance
            spreadStrength = 115 //critical bound point of distance(130-70)
        case .silicon:
            image = Pickaxe.imageSet[5]
            damage = 100
            spread = 300
            spreadStrength = 100
            
        
        }
    }
    
}
