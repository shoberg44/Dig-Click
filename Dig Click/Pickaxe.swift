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
    
    static var imageSet: [UIImage] = [UIImage(systemName: "figure.taichi")!,UIImage(systemName: "trash.square.fill")!]
    var image: UIImage
    var damage: Int = 50
    var spread: Double = 0
    var resistance: Int = 1
    var type: pickType = .wood
    
    init(type: pickType) {
        self.type = type
        switch type {
        case .wood:
            damage = 10
            image = Pickaxe.imageSet[0]
        case .iron:
            damage = 50
            image = Pickaxe.imageSet[1]
        case .silver:
            image = Pickaxe.imageSet[0]
            damage = 25
        case .diamond:
            damage = 70
            image = Pickaxe.imageSet[0]
        case .steel:
            damage = 40
            image = Pickaxe.imageSet[0]
        case .silicon:
            image = Pickaxe.imageSet[0]
            damage = 100
        }
    }
    
}
