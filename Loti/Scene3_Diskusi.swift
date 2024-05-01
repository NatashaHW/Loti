import SpriteKit

class Scene3_Diskusi: SKScene {
    var sembunyikan: SKSpriteNode?
    
    var bgDiskusi: SKSpriteNode?
    var lotiBNW: SKSpriteNode?
    var lotiSemiGreen: SKSpriteNode?
    var lotiGreen: SKSpriteNode?
    var litaBNW: SKSpriteNode?
    var litaSemiYellow: SKSpriteNode?
    var litaYellow: SKSpriteNode?
    
    var scene3IdeLoti1 : SKSpriteNode?
    var scene3IdeLoti2: SKSpriteNode?
    var scene3IdeLoti3: SKSpriteNode?
    var lotiChat1: SKSpriteNode?
    var lotiChat2: SKSpriteNode?
    var lotiChat3: SKSpriteNode?
    var litaChat1: SKSpriteNode?
    
    var busBSD: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
        //    fileprivate let scene3IdeLoti1 = UIImageView(image: UIImage(named: "IdeLoti1"))
    
    //cek node mana yg lagi di drag
    var isDraggingScene3IdeLoti1 = false
    var isDraggingScene3IdeLoti2 = false
    
    var cekDrop1 = false
    var cekDrop2 = false
    
    //simpen posisi node awal
    var originalPosition: CGPoint?
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mengambil node dari scene
        bgDiskusi = childNode(withName: "//bgDiskusi") as? SKSpriteNode
        lotiBNW = childNode(withName: "//LotiStoryIde1") as? SKSpriteNode
        lotiSemiGreen = childNode(withName: "//LotiStoryIde2") as? SKSpriteNode
        lotiGreen = childNode(withName: "//LotiStoryIde3") as? SKSpriteNode
        litaBNW = childNode(withName: "//LitaStoryIde1") as? SKSpriteNode
        litaSemiYellow = childNode(withName: "//LitaStoryIde2") as? SKSpriteNode
        litaYellow = childNode(withName: "//LitaStoryIde3") as? SKSpriteNode
        
        scene3IdeLoti1 = childNode(withName: "//IdeLotiTes") as? SKSpriteNode
        scene3IdeLoti2 = childNode(withName: "//scene3IdeLoti2") as? SKSpriteNode
        scene3IdeLoti3 = childNode(withName: "//scene3IdeLoti3") as? SKSpriteNode
        
        lotiChat1 = childNode(withName: "//lotiChat1") as? SKSpriteNode
        lotiChat2 = childNode(withName: "//lotiChat2") as? SKSpriteNode
        lotiChat3 = childNode(withName: "//lotiChat3") as? SKSpriteNode
        litaChat1 = childNode(withName: "//litaChat1") as? SKSpriteNode
        
        busBSD = childNode(withName: "//busBSD") as? SKSpriteNode
        
        scene3IdeLoti1?.isHidden = false
        scene3IdeLoti2?.isHidden = true
        scene3IdeLoti3?.isHidden = true
        
        lotiChat1?.isHidden = false
        lotiChat2?.isHidden = true
        lotiChat3?.isHidden = true
        litaChat1?.isHidden = false
        busBSD?.isHidden = false
        
        lotiBNW?.isHidden = false
        lotiSemiGreen?.isHidden = true
        lotiGreen?.isHidden = true
        
        litaBNW?.isHidden = false
        litaSemiYellow?.isHidden = true
        litaYellow?.isHidden = true
        
        let slideTo = CGPoint(x: 2856.91, y: 0.7)
        let slideRightAction = SKAction.move(to: slideTo, duration: 2.5)
        slideRightAction.timingMode = .easeIn
        busBSD?.run(slideRightAction)
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first as? SKSpriteNode {
                if node == scene3IdeLoti1 {
                    print("touch began for scene3IdeLoti1")
                    originalPosition = CGPoint(x: -300.2, y: -904.996)
//                    print("\(originalPosition!)")
                    isDraggingScene3IdeLoti1 = true
                } else if node == scene3IdeLoti2 {
                    print("touch began for scene3IdeLoti2")
                    originalPosition = CGPoint(x: -300.2, y: -904.996)
                    isDraggingScene3IdeLoti2 = true
                } else if node == scene3IdeLoti3 {
                    print("touch began for scene3IdeLoti3")
                    originalPosition = CGPoint(x: -300.2, y: -904.996)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = isDraggingScene3IdeLoti1 ? scene3IdeLoti1 : (isDraggingScene3IdeLoti2 ? scene3IdeLoti2 : scene3IdeLoti3) {
                print("holding \(node)")
                node.position = location // Update position to follow touch
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let node = self.nodes(at: location).first as? SKSpriteNode {
                // Ensure you have the original position stored somewhere
                guard let originalPos = originalPosition else {
                    return
                }
                
                // Check if the touch location is within the specified area
                if location.x > 200 && location.y < -375 {
                    // Switch to the next node
                    if node == scene3IdeLoti1 {
                        HapticUtils.hapticIde()
                        print ("drop 1 berhasil")
                        isDraggingScene3IdeLoti1 = false
                        scene3IdeLoti1?.isHidden = true
                        scene3IdeLoti2?.isHidden = false
                        
                        lotiBNW?.isHidden = true
                        lotiBNW?.zPosition = -10
                        lotiSemiGreen?.isHidden = false
                        litaBNW?.isHidden = true
                        litaBNW?.zPosition = -10
                        litaSemiYellow?.isHidden = false
                        
                        let actionLoti1 = SKAction.moveBy(x: -200, y: 0, duration: 0.7)
                        lotiSemiGreen?.run(actionLoti1)
                        litaSemiYellow?.run(actionLoti1)

                    } else if node == scene3IdeLoti2 {
                        HapticUtils.hapticIde()
                        isDraggingScene3IdeLoti2 = false
                        scene3IdeLoti2?.isHidden = true
                        scene3IdeLoti3?.isHidden = false
                        cekDrop2 = true
                        
                        lotiSemiGreen?.isHidden = true
                        lotiSemiGreen?.zPosition = -10
                        lotiGreen?.position = CGPoint(x: -324, y: 303.129)
                        lotiGreen?.isHidden = false
                        litaSemiYellow?.isHidden = true
                        litaSemiYellow?.zPosition = -10
                        litaYellow?.position = CGPoint(x: 450.571, y: 303.129)
                        litaYellow?.isHidden = false
                        litaYellow?.zPosition = 10
                        
                        let actionLoti2 = SKAction.moveBy(x: -360, y: 0, duration: 0.7)
                        lotiGreen?.run(actionLoti2)
                        litaYellow?.run(actionLoti2)
                        
                    } else if node == scene3IdeLoti3 {
                        HapticUtils.hapticIde()
                        node.position = originalPosition!
                        
                        //Tunggu, 1.5 detik, kemudian panggil dan scroll ke Scene4_Envy
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // Panggil Scene2_Halte
                            if let scene4 = Scene4_Envy(fileNamed: "Scene4_Envy") {
                                // Setup scene yang baru
                                scene4.scaleMode = .aspectFill
                                // Transisi ke scene baru
                                self.view?.presentScene(scene4, transition: SKTransition.push(with: .up, duration: 2.0))
                                
                            }
                        }
                    }}
                else {
                    // If the touch location is not within the specified area, return the node to its original position
                    HapticUtils.hapticIde()
                    print("drop failed")
                    isDraggingScene3IdeLoti2 = false
                    isDraggingScene3IdeLoti2 = false
                    node.position = originalPosition!
                }
            }
        }
        
    }
}
