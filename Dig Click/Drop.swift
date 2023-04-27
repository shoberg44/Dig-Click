//
//  Drop.swift
//  Dig Click
//
//  Created by Julie Hoberg on 2/10/23.
//

import Foundation
import UIKit
import GameplayKit
public enum dropType: String, Codable {
case pebble = "pebble"
case diamond = "diamond"
case coal = "coal"
case copper = "copper"
case ruby = "ruby"
case rarity = "rarity"
case unknown = ""
}
public class Drop: Codable{
    var value: Double
    var grade: Int = 50 //a value for a ore that ranges from 50 - 100, 0 for non gradable metal/objects
    var picture: String = "nosign"
    var meltable: Bool
    var weight: Double
    var type: dropType
    var isOre: Bool
    var canSell: Bool
    var name: String

    init(value: Double, picture: String, meltable: Bool, weight: Double, type: dropType, isOre: Bool, canSell: Bool, name: String, grade: Int) { //manual
        self.value = value
        self.grade = grade
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
        self.grade = 0
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
            value = 0.10
            meltable = true
            weight = 1.5
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "pebbles"
        case .coal:
            value = 0.33
            meltable = false
            weight = 1
            canSell = true
            isOre = true
            picture = "coal"
        case .copper:
            value = 1
            meltable = true
            weight = 4
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "copper2"
        case .diamond:
            value = 25
            meltable = true
            weight = 10
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "diamond"
        case .ruby:
            value = 10
            meltable = true
            weight = 5
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "ruby"
        case .rarity:
            value = 0
            meltable = false
            weight = 1
            canSell = true
            isOre = true
            grade = 1
            picture = "rarity"
        case .unknown:
            value = -1
            meltable = false
            weight = -1
            canSell = false
            isOre = false
            grade = 0
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
    func calculateGrade(mean: Float, sd: Float)->Int{
        let distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 50, highestValue: 100), mean: mean, deviation: sd)
        let pick = distribution.nextInt()
        return pick
        
        
    }
}
