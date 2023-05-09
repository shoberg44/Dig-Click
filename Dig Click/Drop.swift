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
    var grade: Int = 100 //a value for a ore that ranges from 50 - 100, 0 for non gradable metal/objects
    var picture: String = "nosign"
    var meltable: Bool
    var weight: Double
    var type: dropType
    var isOre: Bool
    var canSell: Bool
    var name: String
    var UUID: Int = Public.inventory.endIndex
    var gradeValueScale: Int = 10
    var pinned: Bool = false
    
    init(value: Double, picture: String, meltable: Bool, weight: Double, type: dropType, isOre: Bool, canSell: Bool, name: String, grade: Int, gradeValueScale: Int, pinned: Bool) { //manual
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
        self.pinned = pinned
        gradeAdjustValue(scale: gradeValueScale)
    }
    init(type: dropType){ //primary default
        self.type = type
        self.name = type.rawValue
        
        switch type {
        case .pebble:
            value = 0.10
            meltable = true
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "pebbles"
            gradeValueScale = 10
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
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "copper2"
            gradeAdjustValue(scale: 10)
        case .diamond:
            value = 25
            meltable = true
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "diamond"
            gradeAdjustValue(scale: 12)
        case .ruby:
            value = 10
            meltable = true
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "ruby"
            gradeAdjustValue(scale: 15)
        case .rarity:
            value = 0
            meltable = false
            weight = 0
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
            gradeAdjustValue(scale: 10)
        }
        if self.meltable{
            self.weight = calculateWeight()
        }
        
    }
    init(type: dropType, UUID: Int){ //primary default
        self.type = type
        self.name = type.rawValue
        self.UUID = UUID
        switch type {
        case .pebble:
            value = 0.10
            meltable = true
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "pebbles"
            gradeAdjustValue(scale: 10)
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
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "copper2"
            gradeAdjustValue(scale: 10)
        case .diamond:
            value = 25
            meltable = true
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "diamond"
            gradeAdjustValue(scale: 12)
        case .ruby:
            value = 10
            meltable = true
            weight = 1
            canSell = true
            isOre = true
            grade = calculateGrade(mean: 75.5, sd: 10)
            picture = "ruby"
            gradeAdjustValue(scale: 15)
        case .rarity:
            value = 0
            meltable = false
            weight = 0
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
        if self.meltable{
            weight = self.calculateWeight()
            gradeAdjustValue(scale: self.gradeValueScale)
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
    func calculateWeight()->Double{
        let distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 1, highestValue: 200), mean: 100, deviation: 35)
        var pick: Double = Double(distribution.nextInt())
        pick /= 100
        return pick
    }
    func findUUID()->Int{ //takes UUID and returns inventory index. -1 if not found
        for i in 0..<Public.inventory.count{
            if Public.inventory[i].UUID == self.UUID{
                return i
            }
        }
        return -1
    }
    static func findDrop(targetUUID: Int)->Drop{ //takes uuid and returns the drop from the inventory
        for i in 0..<Public.inventory.count{
            if Public.inventory[i].UUID == targetUUID{
                return Public.inventory[i]
            }
        }
        return Drop(type: .unknown)
    }
    func gradeAdjustValue(scale: Int){
        let GRADEMEAN: Double = 75.5
        //let GRADESD: Double = 10
        let SCALECONSTANT = scale //the lower, the quicker a better grade helps. Whemn the difference meets this number, it will double in value.
        
        let differenceGrade = Double(self.grade) - GRADEMEAN //0 1 5 10 15 +-
        let distanceReward: Double = 1 + (differenceGrade / Double(SCALECONSTANT))
        
        self.value *= distanceReward
    }
}
