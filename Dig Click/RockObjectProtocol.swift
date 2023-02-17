//
//  RockObject.swift
//  Dig Click
//
//  Created by Julie Hoberg on 2/10/23.
//

import Foundation
import UIKit
public enum rockType: String {
    case stone = "stone"
    case sandstone = "sandstone"
    case geode = "geode"
}
public protocol Rock{
    static var imageSet: [UIImage] {get set}
    var health: Int { get set }
    var lives: Int { get set }
    var state: Bool { get set}
    var type: rockType {get}
    var location: CGPoint {get set}
    var icon: UIImage {get set}
    var dropChance: Int {get set}
    func breakEvent()->Drop
    func recalculateDropChance()
    
}
