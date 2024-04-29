//
//  Scene3_Ide.swift
//  Loti
//
//  Created by Quinela Wensky on 29/04/24.
//

import Foundation
import SpriteKit

class Scene3_Ide: SKScene{
    var scene3IdeLoti1 : SKSpriteNode?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first {
                if node == scene3IdeLoti1 {
                    print("tes tap")
                }
            }
        }
    }
    
}
