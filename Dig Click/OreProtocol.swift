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
    case igneous = "igneous"
}

public enum mountedType: String {
    case left = "left"
    case right = "right"
    case floor = "floor"
    case ceiling = "ceiling"
    case unmounted = "unmounted"
}

public protocol Rock{
    var baseHealth: Double {get}
    var imageSet: [UIImage] {get set}
    var health: Double { get set }
    var lives: Int { get set }
    var state: Bool { get set}
    var type: rockType {get}
    var location: CGPoint {get set}
    var imageView: UIImageView {get set}
    var dropChance: Int {get set}
    var healthBar: UIProgressView {get set}
    func breakEvent()->Drop
    func recalculateDropChance()
    
}
