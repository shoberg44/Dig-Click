//
//  Drop.swift
//  Dig Click
//
//  Created by Julie Hoberg on 2/10/23.
//

import Foundation
import UIKit
public enum dropType: String {
case pebble = "pebble"
case diamond = "diamond"
case coal = "coal"
case copper = "copper"
case ruby = "ruby"
case rarity = "rarity"
case unknown = ""
}
public class Drop{
    var value: Double
    var picture: UIImage = UIImage(systemName: "nosign")!
    var meltable: Bool
    var weight: Double
    var type: dropType
    var isOre: Bool
    var canSell: Bool
    var name: String

    init(value: Double, picture: UIImage, meltable: Bool, weight: Double, type: dropType, isOre: Bool, canSell: Bool, name: String) { //manual
        self.value = value
        self.picture = picture
        self.meltable = meltable
        self.weight = weight
        self.type = type
        self.isOre = isOre
        self.canSell = canSell
        self.type = type
        self.name = name
    }
    init(isOre: Bool, name: String, canSell: Bool){ //short custom
        self.value = 0
        self.meltable = false
        self.weight = 0
        self.isOre = isOre
        self.canSell = canSell
        self.type = .unknown
        self.name = name
    }
    init(type: dropType){ //primary default
        self.type = type
        self.name = type.rawValue
        
        switch type {
        case .pebble:
            value = 0.01
            meltable = true
            weight = 1.5
            canSell = true
            isOre = true
        case .coal:
            value = 0.1
            meltable = false
            weight = 1
            canSell = true
            isOre = true
        case .copper:
            value = 1
            meltable = true
            weight = 4
            canSell = true
            isOre = true
        case .diamond:
            value = 100
            meltable = false
            weight = 10
            canSell = true
            isOre = true
        case .ruby:
            value = 50
            meltable = false
            weight = 5
            canSell = true
            isOre = true
        case .rarity:
            value = 0
            meltable = false
            weight = 1
            canSell = true
            isOre = true
        case .unknown:
            value = 0
            meltable = false
            weight = 0
            canSell = false
            isOre = false
        }
    }
    
    //functions
    
    func meltOre(_ meltInto: Drop)->(Bool,Drop){
        if (self.meltable && meltInto.meltable)&&(self.value == meltInto.value){
            meltInto.value += self.value
            meltInto.weight += self.weight
            return (true,meltInto)
        }
        else{
            print("melt failed")
            return (false, Drop(type: .unknown))
        }
    }
}
