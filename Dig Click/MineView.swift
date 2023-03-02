//
//  MineView.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/9/23.
//

import UIKit
class Public{
    static var money: Double = 0
    static var inventory: [Drop] = []
    static var pickaxe: Pickaxe = Pickaxe(type: .wood)
}
class MineView: UIViewController {
    
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var pickIconOutlet: UIImageView!
    
    let PICKDEFAULT: CGPoint = CGPoint(x: 196.0, y: 738.3) //constant for pick location
    
    ///Rock Decaration
    //when declaring, requires an both a CGPoint for "location" and an image for "icon"
    //within specific rock type classes use imageSet[] to get images that corrispond to that type. The location used here is hard coded and should be proc generated in the future
    
    
    var ores = [Rock]() //array of ores on scene
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newOreNode(type: .stone, loc: CGPoint(x: 289.0, y: 401.0), mount: .unmounted)
        newOreNode(type: .stone, loc: CGPoint(x: 100, y: 401.0), mount: .ceiling)
        pickIconOutlet.image = Public.pickaxe.image
        Public.pickaxe = Pickaxe(type: .steel)
        updateView()
    }
    
    func newOreNode(type: rockType, loc: CGPoint, mount: mountedType){
        var newOre: Rock
        
        //create corrisponding object
        switch type {
        case .stone:
            newOre = StoneRock(location: loc, mount: mount)
        case .geode:
            newOre = StoneRock(location: loc, mount: mount)
        case .sandstone:
            newOre = StoneRock(location: loc, mount: mount)
        }
        //append object to ore array
        ores.append(newOre)
        
        //adds to view
        view.addSubview(newOre.imageView)
    }
    
    @IBAction func pickPanGesture(_ sender: UIPanGestureRecognizer) {
        if !(sender.state == .ended){ //runs twice so it fixes that problem
            let loc = sender.location(in: view)
            pickIconOutlet.center = loc //puts image at drag gesture
            
            for i in 0..<ores.count{ //finds ore
            
                if (CGRectIntersectsRect(ores[i].imageView.frame, pickIconOutlet.frame)) {//detects collision
                    sender.state = .ended //ends drag
                    
                    Public.money += 1
                    ores[i].health -= Public.pickaxe.damage
                    print("Health: \(ores[i].health)")
                    pickIconOutlet.center = PICKDEFAULT //resets posistion
                    updateView()//updates view (just score for now)
                }
                
            }
            
        }
        
        
        
        
    }
    
    func dropOre(_ rockNode: Rock){
        
        //reconizes type as its child TEMP i belive
        switch rockNode.type {
        case .stone:
            var tempRock = rockNode as! StoneRock
            tempRock.recalculateDropChance()
        default:
            var tempRock = rockNode as! StoneRock
        }
        
        //gets drop
        let currentDrop = rockNode.breakEvent()
        Public.inventory.append(currentDrop)
        print(currentDrop.name)
        
        //creates drop image view
        let image = currentDrop.picture
        let imageView = UIImageView(image: image)//refrence?
        imageView.frame = CGRect(x: rockNode.location.x, y: rockNode.location.y, width: 80, height: 80)
        view.addSubview(imageView)
        
        //animation
        var time = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if imageView.frame.contains(CGPoint(x: imageView.center.x, y: 780)){
                time += 0.05
                
                imageView.center.y += pow(time, 2)*16+100*time-4 //gravity
            }
            else{
                timer.invalidate()
                time = 0.5
                var iterations = 0
                Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer2 in
                    iterations += 1
                    
                    time = time - 0.07
                    imageView.center.y -= pow(time, 2)*16+100*time-20
                    if iterations >= 15{
                        imageView.isHidden = true
                        timer2.invalidate()
                    }
                }
                
            }
        }
        
    }
        
    
        func updateView(){
            
            //formats money
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
                moneyOutlet.text = "\(formattedTipAmount)"
            }
            //detects ore health
            for i in 0..<ores.count{
                ores[i].healthBar.removeFromSuperview()
                if ores[i].health <= 0{
                    dropOre(ores[i])//runs animation + drop logic
                    ores[i].imageView.removeFromSuperview()
                    ores[i].healthBar.removeFromSuperview()
                    print("attempting to remove ore index: \(i)")
                    print("Current Array \(ores)")
                    ores.remove(at: i) //shifts array when removes
                    
                }
                else if ores[i].health < 100{
                    ores[i].healthBar.progress = Float(ores[i].health) / 100
                    view.addSubview(ores[i].healthBar)//adds health bar to subview
                }
            }
        }
        
}
