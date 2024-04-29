//import UIKit
//import SwiftUI
//
//class GameViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Membuat tampilan SwiftUI
//        let contentView = Transisi_Kamar()
//
//        // Mengonversi tampilan SwiftUI menjadi tampilan UIKit
//        let hostingController = UIHostingController(rootView: contentView)
//
//        // Menambahkan tampilan SwiftUI sebagai child view controller
//        addChild(hostingController)
//
//        // Menambahkan tampilan UIKit ke tampilan GameViewController
//        view.addSubview(hostingController.view)
//
//        // Mengatur constraint untuk tampilan UIKit
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//        // Mengakhiri penambahan tampilan sebagai child view controller
//        hostingController.didMove(toParent: self)
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//}



//  GameViewController.swift
//  Loti
//
//  Created by Natasha Hartanti Winata on 25/04/24.


import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'Scene1.sks'
            if let scene = SKScene(fileNamed: "Scene3_Diskusi") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
