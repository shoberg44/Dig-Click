//
//  Upgrade.swift
//  Dig Click
//
//  Created by Julie Hoberg on 5/6/23.
//

import Foundation
public class Upgrade: Codable{
    var spread: Double
    var resistance: Int = 1
    var damage: Double
    var spreadStrength: Double
    init(spread: Double, resistance: Int, damage: Double, spreadStrength: Double) {
        self.spread = spread
        self.resistance = resistance
        self.damage = damage
        self.spreadStrength = spreadStrength
    }
    init(){
        spread = -1
        resistance = -1
        damage = 0
        spreadStrength = -1
    }
}
//let bottom = (Public.pickaxe.spreadStrength/distance) * (Public.pickaxe.damage/3)
//print("1: \(Public.pickaxe.spreadStrength/distance) | 2: \(Public.pickaxe.damage/3) | both: \((Public.pickaxe.spreadStrength/distance) * (Public.pickaxe.damage/3))")
//ores[other].health -= bottom
//print("top: \(0) | bottom: \(bottom) | both: \(bottom)")
