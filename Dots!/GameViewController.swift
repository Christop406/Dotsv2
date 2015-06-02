//
//  GameViewController.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/17/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import UIKit
import SpriteKit
import iAd
import GameKit

//TODO: Make "press button" clickable
//TODO: Fix Crashes if the player touches off the ball

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, ADBannerViewDelegate {
    
    //var bannerAd:ADBannerView = ADBannerView()
    var adBannerView: ADBannerView = ADBannerView()

    override func viewDidLoad() {
        loadAds()
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showiAdBanner", name: "showiAdBanner", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideiAdBanner", name: "hideiAdBanner", object: nil)
        //NSNotificationCenter.defaultCenter().postNotificationName("showiAdBanner", object: nil)
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill

            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.Portrait.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.Portrait.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        adBannerView.hidden = true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        adBannerView.hidden = true
    }
    
    func loadAds(){
        adBannerView = ADBannerView(frame: CGRect.zeroRect)
        adBannerView.center = CGPoint(x: adBannerView.center.x, y: view.bounds.size.height - adBannerView.frame.size.height / 2)
        adBannerView.delegate = self
        adBannerView.hidden = true
        adBannerView.layer.zPosition = 10
        view.addSubview(adBannerView)
    }
    
    func showiAdBanner() {
        if adBannerView.bannerLoaded {
            adBannerView.hidden = false
        }
    }
    
    func hideiAdBanner() {
        adBannerView.hidden = true
    }
    
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer()
        localPlayer.authenticateHandler = {(var gameCenterVC:UIViewController!, var gameCenterError:NSError!) -> Void in
            
            if gameCenterVC != nil {
                self.presentViewController(gameCenterVC, animated: true, completion: { () -> Void in
                    
                })
            }
        }
    }


}
