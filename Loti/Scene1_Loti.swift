//
//  Scene1.swift
//  Loti
//
//  Created by Natasha Hartanti Winata on 25/04/24.
//

import SpriteKit
import GameplayKit

class Scene1_Loti: SKScene {
    
    var scene1SleepColor: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        scene1SleepColor = childNode(withName: "//scene1SleepColor") as? SKSpriteNode
        
    }
    
}
