//
//  Rock.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/15/23.
//
//"pebble"
//"diamond"
//"coal"
//"copper"
//"ruby"
//"rarity"

import Foundation
import UIKit
class StoneRock: Rock{
    
    static var imageSet: [UIImage] = [UIImage(systemName: "nosign")!]
    var icon: UIImage
    var location: CGPoint
    var health: Int = 100
    var lives: Int = 1
    var state: Bool = false
    var type: rockType = .stone
    var dropChance = Int.random(in: 0 ... 100)
    var mountedType: mountedType = .unmounted
    
    init(icon: UIImage, location: CGPoint, mount: mountedType) {
        self.icon = icon
        self.location = location
        self.mountedType = mount
    }
    
    func breakEvent() -> Drop {
        var newDrop: Drop
        if dropChance <= 5{ // 5
            newDrop = Drop(type: .rarity)
        }
        else if (dropChance <= 10){ //5
            newDrop = Drop(type: .diamond)
        }
        else if dropChance <= 17{ //7
            newDrop = Drop(type: .ruby)
        }
        else if dropChance <= 32{ //15
            newDrop = Drop(type: .copper)
        }
        else if dropChance <= 50{ //18
            newDrop = Drop(type: .coal)
        }
        else{ //50
            newDrop = Drop(type: .pebble)
        }
        return newDrop
    }
    func recalculateDropChance(){
        dropChance = Int.random(in: 0 ... 100)
    }
}
