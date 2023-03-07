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
    
    static var imageSet: [UIImage] = [UIImage(systemName: "nosign")!,UIImage(systemName: "trash.square.fill")!]
    var imageView: UIImageView
    var location: CGPoint
    var health: Int = 100
    var lives: Int = 1
    var state: Bool = false
    var type: rockType = .stone
    var dropChance = Int.random(in: 0 ... 100)
    var mountedType: mountedType = .unmounted
    var healthBar: UIProgressView
    init(location: CGPoint, mount: mountedType) {
        switch mount {
        case .unmounted:
            imageView = UIImageView(image: StoneRock.imageSet[0])
        case .ceiling:
            imageView = UIImageView(image: StoneRock.imageSet[1])
        case .floor:
            imageView = UIImageView(image: StoneRock.imageSet[2])
        case .left:
            imageView = UIImageView(image: StoneRock.imageSet[3])
        case .right:
            imageView = UIImageView(image: StoneRock.imageSet[4])
        }
        
        imageView.frame = CGRect(x: location.x, y: location.y, width: Public.iconSize, height: Public.iconSize)
        
        //CGPoint(x: location.x-(iconSize/2), y: location.y-(iconSize/2))
        
        self.location = location
        self.mountedType = mount
        
        healthBar = UIProgressView(frame: CGRect(origin: CGPoint(x: location.x, y: location.y + 100), size: CGSize(width: 100, height: 5)))
        healthBar.progressTintColor = UIColor.green
        healthBar.trackTintColor = UIColor.gray
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
