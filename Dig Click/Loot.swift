//
//  Loot.swift
//  Dig Click
//
//  Created by Julie Hoberg on 5/6/23.
//

import Foundation
import GameplayKit
public enum lootType: String, Codable{
    case money = "money"
    case drop = "drop"
    case upgrade = "upgrade"
}
public class Loot: Codable{
    var money: Int = 0
    var drop: Drop = Drop(type: .unknown, UUID: -1)
    var upgrade: Upgrade = Upgrade()
    init(type: lootType) {
        switch type {
        case .money:
            money = genMoney()
        case .drop:
            drop = genDrop()
        case .upgrade: break
            
        }
    }
    func genMoney()->Int{
        let rand = Int.random(in: 1...4)
        var distribution: GKGaussianDistribution
        switch rand {
        case 1:
            distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 1, highestValue: 15), mean: 7, deviation: 3)
        case 2:
            distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 20, highestValue: 40), mean: 28, deviation: 7)
        case 3:
            distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 50, highestValue: 125), mean: 70, deviation: 15)
        case 4:
            distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 1, highestValue: 15), mean: 7, deviation: 3)
        default:
            return 1
        }
        return distribution.nextInt()
    }
    func genDrop()->Drop{
        let newDrop = Igneous(location: CGPoint(), mount: .unmounted).breakEvent()
        return newDrop
    }
}
//let distribution = GKGaussianDistribution(randomSource: GKRandomDistribution(lowestValue: 50, highestValue: 100), mean: mean, deviation: sd)
//let pick = distribution.nextInt()
