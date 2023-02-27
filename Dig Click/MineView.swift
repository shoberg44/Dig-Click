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
}
class MineView: UIViewController {
    
    @IBOutlet weak var dropIcon: UIImageView!
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var ore1Icon: UIImageView!
    @IBOutlet weak var pickIconOutlet: UIImageView!
    
    let PICKDEFAULT: CGPoint = CGPoint(x: 196.0, y: 738.3) //constant for pick location
    
    ///Rock Decaration
    //when declaring, requires an both a CGPoint for "location" and an image for "icon"
    //within specific rock type classes use imageSet[] to get images that corrispond to that type. The location used here is hard coded and should be proc generated in the future
    
    
    var ores = [Rock]() //array of ores on scene
    var oreImageViews = [UIImageView]() //parralel array of image views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newOreNode(type: .stone, loc: CGPoint(x: 289.0, y: 401.0), mount: .unmounted)
        updateView()
    }
    
    func newOreNode(type: rockType, loc: CGPoint, mount: mountedType){
        var newOre: Rock
        //create corrisponding object
        switch type {
        case .stone:
            newOre = StoneRock(icon: StoneRock.imageSet[1], location: loc, mount: mount)
        default:
            newOre = StoneRock(icon: StoneRock.imageSet[1], location: loc, mount: mount)
        }
        
        
        ores.append(newOre) //append object
        
        //create image
        let image = newOre.icon
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: newOre.location.x, y: newOre.location.y, width: 80, height: 80)
        view.addSubview(imageView)
        oreImageViews.append(imageView) //append corrisponding view to parralel array
        
        
    }
    
    @IBAction func pickPanGesture(_ sender: UIPanGestureRecognizer) {
        if !(sender.state == .ended){ //runs twice so it fixes that problem
            let loc = sender.location(in: view)
            pickIconOutlet.center = loc //puts image at drag gesture
            
            for i in 0..<oreImageViews.count{
                if (CGRectIntersectsRect(oreImageViews[i].frame, pickIconOutlet.frame)) {//detects collision
                    sender.state = .ended //ends drag
                    intersectionEvent()
                }
            }
            
        }
        
        
        
        
    }
    
    func intersectionEvent(){
        Public.money += 1
        dropOre(ores[0])//runs animation + drop logic
        pickIconOutlet.center = PICKDEFAULT //resets posistion
        updateView()//updates view (just score for now)
    }
    
    func dropOre(_ rockNode: Rock){
        
        //reconizes type as its child
        switch rockNode.type {
        case .stone:
            var tempRock = rockNode as! StoneRock
            tempRock.recalculateDropChance()
        default:
            var tempRock = rockNode as! StoneRock
        }
        
        //gets drop
        var currentDrop = rockNode.breakEvent()
        print(currentDrop.name)
        Public.inventory.append(currentDrop)
        
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
        }
        
}
