//
//  Social Media.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/26.
//  Copyright © 2018 Lighthouse. All rights reserved.
//
import UIKit

class Share : UIActivityViewController {
    init(in ViewController : UIViewController, for score : Int) {
        let info = "I scored \(score) in A-Void! Can you do better? \n https://itunes.apple.com/za/app/a-void/id1422610761?mt=8"
        let gameImage : UIImage = #imageLiteral(resourceName: "ShareImage")
        let activityItems = [gameImage, info] as [Any]
        super.init(activityItems: activityItems, applicationActivities: nil)
        popoverPresentationController?.sourceView = ViewController.view
        ViewController.present(self, animated: true, completion: nil)
    }
}

