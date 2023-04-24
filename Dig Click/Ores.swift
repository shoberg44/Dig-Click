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
    
    var imageSet: [UIImage] = [UIImage(named: "RockVar1.png")!]
    var imageView: UIImageView
    var location: CGPoint
    var health: Double = 100
    var lives: Int = 1
    var state: Bool = false
    var type: rockType = .stone
    var dropChance = Int.random(in: 0 ... 100)
    var mountedType: mountedType = .unmounted
    var healthBar: UIProgressView
    init(location: CGPoint, mount: mountedType) {
        switch mount {
        case .unmounted:
            imageView = UIImageView(image: imageSet[0])
        case .ceiling:
            imageView = UIImageView(image: imageSet[0])
        case .floor:
            imageView = UIImageView(image: imageSet[0])
        case .left:
            imageView = UIImageView(image: imageSet[0])
        case .right:
            imageView = UIImageView(image: imageSet[0])
        }
        
        imageView.frame = CGRect(x: location.x, y: location.y, width: Double(Public.iconSize), height: Double(Public.iconSize))
        
        
        self.location = location
        self.mountedType = mount
        
        healthBar = UIProgressView(frame: CGRect(origin: CGPoint(x: location.x, y: location.y + 100), size: CGSize(width: 100, height: 5)))
        healthBar.progressTintColor = UIColor.green
        healthBar.trackTintColor = UIColor.gray
    }
    
    func breakEvent() -> Drop {
        var newDrop: Drop
        if dropChance <= 4{ // 5
            newDrop = Drop(type: .rarity)
        }
        else if (dropChance <= 9){ //5
            newDrop = Drop(type: .diamond)
        }
        else if dropChance <= 15{ //7
            newDrop = Drop(type: .ruby)
        }
        else if dropChance <= 25{ //15
            newDrop = Drop(type: .copper)
        }
        else if dropChance <= 45{ //18
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
class Sandstone: Rock{
    
    var imageSet: [UIImage] = [UIImage(named: "RockVar2.png")!]
    var imageView: UIImageView
    var location: CGPoint
    var health: Double = 70
    var lives: Int = 1
    var state: Bool = false
    var type: rockType = .sandstone
    var dropChance = Int.random(in: 0 ... 100)
    var mountedType: mountedType = .unmounted
    var healthBar: UIProgressView
    init(location: CGPoint, mount: mountedType) {
        switch mount {
        case .unmounted:
            imageView = UIImageView(image: imageSet[0])
        case .ceiling:
            imageView = UIImageView(image: imageSet[0])
        case .floor:
            imageView = UIImageView(image: imageSet[0])
        case .left:
            imageView = UIImageView(image: imageSet[0])
        case .right:
            imageView = UIImageView(image: imageSet[0])
        }
        
        imageView.frame = CGRect(x: location.x, y: location.y, width: Double(Public.iconSize), height: Double(Public.iconSize))
        
        
        self.location = location
        self.mountedType = mount
        
        healthBar = UIProgressView(frame: CGRect(origin: CGPoint(x: location.x, y: location.y + 100), size: CGSize(width: 100, height: 5)))
        healthBar.progressTintColor = UIColor.green
        healthBar.trackTintColor = UIColor.gray
    }
    
    func breakEvent() -> Drop {
        var newDrop: Drop
        if dropChance <= 10{ // 10
            newDrop = Drop(type: .rarity)
        }
        else if (dropChance <= 5){ //5
            newDrop = Drop(type: .diamond)
        }
        else if dropChance <= 15{ //30
            newDrop = Drop(type: .ruby)
        }
        else if dropChance <= 20{ //50
            newDrop = Drop(type: .copper)
        }
        else if dropChance <= 30{ //80
            newDrop = Drop(type: .coal)
        }
        else{ //20 100
            newDrop = Drop(type: .pebble)
        }
        return newDrop
    }
    func recalculateDropChance(){
        dropChance = Int.random(in: 0 ... 100)
    }
}
class Igneous: Rock{
    
    var imageSet: [UIImage] = [UIImage(named: "RockVar3.png")!]
    var imageView: UIImageView
    var location: CGPoint
    var health: Double = 150
    var lives: Int = 1
    var state: Bool = false
    var type: rockType = .sandstone
    var dropChance = Int.random(in: 0 ... 100)
    var mountedType: mountedType = .unmounted
    var healthBar: UIProgressView
    init(location: CGPoint, mount: mountedType) {
        switch mount {
        case .unmounted:
            imageView = UIImageView(image: imageSet[0])
        case .ceiling:
            imageView = UIImageView(image: imageSet[0])
        case .floor:
            imageView = UIImageView(image: imageSet[0])
        case .left:
            imageView = UIImageView(image: imageSet[0])
        case .right:
            imageView = UIImageView(image: imageSet[0])
        }
        
        imageView.frame = CGRect(x: location.x, y: location.y, width: Double(Public.iconSize), height: Double(Public.iconSize))
        
        
        self.location = location
        self.mountedType = mount
        
        healthBar = UIProgressView(frame: CGRect(origin: CGPoint(x: location.x, y: location.y + 100), size: CGSize(width: 100, height: 5)))
        healthBar.progressTintColor = UIColor.green
        healthBar.trackTintColor = UIColor.gray
    }
    
    func breakEvent() -> Drop {
        var newDrop: Drop
        if dropChance <= 7{ // 10
            newDrop = Drop(type: .rarity)
        }
        else if (dropChance <= 15){ //22
            newDrop = Drop(type: .diamond)
        }
        else if dropChance <= 15{ //37
            newDrop = Drop(type: .ruby)
        }
        else if dropChance <= 20{ //57
            newDrop = Drop(type: .copper)
        }
        else if dropChance <= -1{ //87
            newDrop = Drop(type: .coal)
        }
        else{ //20 100
            newDrop = Drop(type: .pebble)
        }
        return newDrop
    }
    func recalculateDropChance(){
        dropChance = Int.random(in: 0 ... 100)
    }
}
