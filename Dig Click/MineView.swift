//
//  MineView.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/9/23.
//

import UIKit
import GameplayKit



class MineView: UIViewController {
    
    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var moneyOutlet: UILabel! //Web Safe Color 669900 to SystemRed
    @IBOutlet weak var pickIconOutlet: UIImageView!
    
    let PICKDEFAULT: CGPoint = CGPoint(x: 196.0, y: 738.3) //constant for pick location
    let MAXINVENTORYSPACE: Int = 100 //max space in inventory
    
    var alertController: UIAlertController?
    var okAction: UIAlertAction?
    
    ///Rock Decaration
    //when declaring, requires an both a CGPoint for "location" and an image for "icon"
    //within specific rock type classes use imageSet[] to get images that corrispond to that type. The location used here is hard coded and should be proc generated in the future

    var mersenneTwister: GKMersenneTwisterRandomSource = GKMersenneTwisterRandomSource(seed: Public.seed) //seed generator generates a new number from
    
    
    
    var ores = [Rock]() //array of ores on scene
    var oreGenLoc = [CGPoint]() //array of potental ore generation spots
    var offset: CGFloat = CGFloat(Public.iconSize/2)
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController = UIAlertController(title: "Not Enough Space", message: "Your inventory has a maximum capacity of \(MAXINVENTORYSPACE). You have reached that limit. Sell items to get more space!", preferredStyle: .alert)
        okAction = UIAlertAction(title: "Back", style: .default){ [self]_ in
            alertController?.dismiss(animated: false)
            self.performSegue(withIdentifier: "MineToMarketSeque", sender: self)
            alertController?.dismiss(animated: false)
        
        }
        alertController!.addAction(okAction!)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backround")!)
        pickIconOutlet.image = UIImage(named:Public.pickaxe.image)
        
        for UIImage in view.subviews{
            if UIImage.tag == 33{
                oreGenLoc.append(CGPoint(x: UIImage.center.x - offset, y: UIImage.center.y - offset))
            }
        }
        generateMine()
        updateView()
        
    }
    
    
    

    
    
    func newOreNode(type: rockType, loc: CGPoint, mount: mountedType){
        var newOre: Rock
        
        //create corrisponding object
        switch type {
        case .stone:
            newOre = StoneRock(location: loc, mount: mount)
        case .igneous:
            newOre = Igneous(location: loc, mount: mount)
        case .sandstone:
            newOre = Sandstone(location: loc, mount: mount)
        }
        //append object to ore array
        ores.append(newOre)
        
        //adds to view
        view.addSubview(newOre.imageView)
    }
    
    @IBAction func pickPanGesture(_ sender: UIPanGestureRecognizer) {
        if Public.inventory.count > MAXINVENTORYSPACE{
            pickIconOutlet.center = PICKDEFAULT //resets posistion
            inventoryLabel.isHidden = false
            //present(alertController!, animated: false)
            
        }
        else if !(sender.state == .ended){ //runs twice so it fixes that problem
            inventoryLabel.isHidden = true
            let loc = sender.location(in: view)
            pickIconOutlet.center = loc //puts image at drag gesture
            
            for i in 0..<ores.count{ //finds ore
            
                if (CGRectIntersectsRect(ores[i].imageView.frame, pickIconOutlet.frame)) {//detects collision
                    sender.state = .ended //ends drag
                    
                    ores[i].health -= Public.pickaxe.damage
                    //print("Health: \(ores[i].health)")
                    pickIconOutlet.center = PICKDEFAULT //resets posistion
                    for other in 0..<ores.count{
                        let x1 = ores[other].location.x
                        let x2 = ores[i].location.x
                        let y1 = ores[other].location.y
                        let y2 = ores[i].location.y
                        
                        let distance = sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2))
                        if distance <= Public.pickaxe.spread && distance != 0{
                            
                            
                            let bottom = (Public.pickaxe.spreadStrength/distance) * (Public.pickaxe.damage/3)
                            //print("1: \(Public.pickaxe.spreadStrength/distance) | 2: \(Public.pickaxe.damage/3) | both: \((Public.pickaxe.spreadStrength/distance) * (Public.pickaxe.damage/3))")
                            ores[other].health -= bottom
                            //print("top: \(0) | bottom: \(bottom) | both: \(bottom)")
                            
                        }
                        
                    }
                    
                }
                
            }
            updateView()
            
        }
        
        
        
        
    }
    
    func dropOre(_ rockNode: Rock){
        //gets drop
        let currentDrop = rockNode.breakEvent()
        Public.inventory.append(currentDrop)
        print(currentDrop.name)
        
        //creates drop image view
        let image = UIImage(named: currentDrop.picture)
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
                        imageView.willRemoveSubview(imageView)
                        timer2.invalidate()
                    }
                }
                
            }
        }
        //post animation save
        save()
    }
        
    
    func updateView(){
        
//detects ore health
        for i in 0..<ores.count{
            ores[i].healthBar.removeFromSuperview()
            if ores[i].health <= 0{
                Public.money += 1
                dropOre(ores[i])//runs animation + drop logic
                ores[i].imageView.removeFromSuperview()
                ores[i].healthBar.removeFromSuperview()
                
            }
            else if ores[i].health < ores[i].baseHealth{
                ores[i].healthBar.progress = Float(ores[i].health / ores[i].baseHealth)
                view.addSubview(ores[i].healthBar)//adds health bar to subview
            }
        }
        ores.removeAll(where: {$0.health <= 0})
        
        //formats money
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
            moneyOutlet.text = "\(formattedTipAmount)"
        }
        if ores.count == 0{
            generateMine()
        }
        
    }
    //generates the mine ore locations
    func generateMine(){
        let ORESCOUNT = 10
        let randLoc = oreGenLoc.shuffled().prefix(ORESCOUNT) //from all ore spawns, takes a random # of them
        
        if Public.randomSeed{
            Public.seed = UInt64.random(in: 0..<9999999)
            print("new seed \(Public.seed)")
        }
        
        for i in 0..<randLoc.count{
            let randOre = generateSeed(base: Public.seed, upper: 6)
            if randOre == 1 {
                newOreNode(type: .igneous, loc: randLoc[i], mount: .unmounted)
            }
            else if randOre <= 3{
                newOreNode(type: .sandstone, loc: randLoc[i], mount: .unmounted)
            }
            else{
                newOreNode(type: .stone, loc: randLoc[i], mount: .unmounted)
            }
        }
        view.bringSubviewToFront(moneyOutlet)
        
    }
    func generateSeed(base: UInt64, upper: Int)->Int{
        let seededOutput = mersenneTwister.nextInt(upperBound: upper) //generates from 1 to upper-1 inclusive
        return seededOutput
    }
    func save(){
        print("saved money | inventory")
        Public.defaults.set(Public.money, forKey: "money")
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.inventory)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "inventory")

        } catch {
            print("Unable to Encode inventory (\(error))")
        }
    }
}
