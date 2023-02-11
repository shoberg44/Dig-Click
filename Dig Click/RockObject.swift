//
//  RockObject.swift
//  Dig Click
//
//  Created by Julie Hoberg on 2/10/23.
//

import Foundation
public enum rockType: String {
    case stone = "stone"
    case sandstone = "sandstone"
    case geode = "geode"
}
public protocol Rock{
    var health: Int { get set }
    var lives: Int { get set }
    var state: Bool { get set}
    var type: rockType {get}
    func breakEvent()->Drop
}
