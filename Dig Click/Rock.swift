//
//  Rock.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/15/23.
//

import Foundation
class StoneRock: Rock{
    var health: Int = 100
    var lives: Int = 1
    var state: Bool = false
    var type: rockType = .stone
    var dropChance = Int.random(in: 0 ... 100)
    
    func breakEvent() -> Drop {
        var newDrop: Drop
        if dropChance <= 10{
            newDrop = Drop(type: .rarity)
        }
        else if (dropChance <= 35){
            print(dropChance.round())
            newDrop = Drop(type: .unknown)
        }
        else{
            newDrop = Drop(type: .unknown)
        }
        return newDrop
    }
}
