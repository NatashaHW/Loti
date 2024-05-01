//
//  Scene 7_Hug.swift
//  Loti
//
//  Created by Quinela Wensky on 30/04/24.
//

import SpriteKit

class Scene7_Hug: SKScene {
    var hugBefore: SKSpriteNode?
    var hugAfter: SKSpriteNode?
    var sceneEnding1: SKSpriteNode?
    
    var sceneEnding2 = SKSpriteNode(imageNamed: "bgEndingGabung2")
    var heartComplete = SKSpriteNode(imageNamed: "heartComplete")
    
    var heartLeft: SKSpriteNode?
    var heartRight: SKSpriteNode?
    
    var originalPosition: CGPoint?
    var originalPositionLeft: CGPoint?
    var originalPositionRight: CGPoint?
    
    var isDragHeartLeft = false
    var isDragHeartRight = false
    var heartLeftLocked = false
    var heartRightLocked = false
    
    //cropnode and cameraNode
    var cropNode: SKCropNode!
    var cameraNode: SKCameraNode?
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        // Mendapatkan referensi ke node
        hugBefore = childNode(withName: "//HugBefore") as? SKSpriteNode
        hugAfter = childNode(withName: "//HugAfter") as? SKSpriteNode
        sceneEnding1 = childNode(withName: "//ending1") as? SKSpriteNode
        
        heartLeft = childNode(withName: "//heartLeft") as? SKSpriteNode
        heartRight = childNode(withName: "//heartRight") as? SKSpriteNode
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        //declare visibility aset
        hugBefore?.isHidden=false
        hugAfter?.alpha=0
        sceneEnding1?.isHidden=false
        sceneEnding2.isHidden=false
        
        showHugAndMoveCamera()
        
        //        //masukkan mask
        //        cropNode = SKCropNode()
        //
        //        sceneEnding2.position = CGPoint(x: sceneEnding1!.position.x, y: sceneEnding1!.position.y)
        //
        //        //buat shape lingkaran utk mask
        //        let maskNode = SKShapeNode(circleOfRadius: 200)
        //        maskNode.fillColor = .black
        //        maskNode.position = CGPoint(x:sceneEnding1!.position.x, y:sceneEnding1!.position.y)
        //
        //        cropNode.maskNode = maskNode
        //        cropNode.zPosition = 10
        //
        //        if heartLeftLocked == true && heartRightLocked == true {
        //            addChild(cropNode)
        //            cropNode.addChild(sceneEnding2)
        //            print("puzzle state true")
        //            animateMask()
        //        }
    }
    
    func showHugAndMoveCamera() {
        let sceneHugDelay = SKAction.wait(forDuration: 1)
        let sceneHugDelay2 = SKAction.wait(forDuration: 0.5)
        let showSceneHugAfter = SKAction.run {
            self.hugAfter?.isHidden = false
            self.hugAfter?.alpha = 0.5
        }
        
        let showSceneHugAfter1 = SKAction.run {
            self.hugAfter?.alpha = 1
        }
        
        let sequenceToShowSceneHug = SKAction.sequence([sceneHugDelay, showSceneHugAfter, sceneHugDelay2, showSceneHugAfter1])
        
        // Menggerakkan kamera ke sceneEnding
        let moveCameraToSceneEnding = SKAction.move(to: sceneEnding1!.position, duration: 2.0)
        let waitBeforeMoveCamera = SKAction.wait(forDuration: 1.5)
        let sequenceMoveCameraToSceneEnding = SKAction.sequence([waitBeforeMoveCamera, moveCameraToSceneEnding])
        
        // Menjalankan urutan aksi
        cameraNode?.run(SKAction.sequence([sequenceToShowSceneHug, sequenceMoveCameraToSceneEnding, sequenceMoveCameraToSceneEnding]))
    }
    
    func animateMask() {
        
        let mask = cropNode.maskNode as? SKShapeNode
        
        let maskAnimate = SKAction.run {
            mask?.run(SKAction.scale(to: 2000, duration: 3))
        }
        
        print("animationrun")
        mask?.run(SKAction.sequence([maskAnimate]))
    }
    
    func maskAnimation() {
        if heartLeftLocked && heartRightLocked {
            cropNode = SKCropNode()
            sceneEnding2.position = CGPoint(x: sceneEnding1!.position.x, y: sceneEnding1!.position.y)
            heartComplete.position = CGPoint(x: 4.921, y: -3462.501)
            
            // Create a mask node
            let maskNode = SKShapeNode(circleOfRadius: 1)
            maskNode.fillColor = .black
            maskNode.position = CGPoint(x: 4.921, y: -3462.501)
            
            // Set the mask node and add crop node to the scene
            cropNode.maskNode = maskNode
            cropNode.zPosition = 10
            addChild(cropNode)
            
            // Add sceneEnding2 to crop node
            cropNode.addChild(sceneEnding2)
            
            // Add heartComplete to crop node after setting up the mask
            cropNode.addChild(heartComplete)
            
            animateMask()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first as? SKSpriteNode {
                if node == heartLeft && heartLeftLocked == false {
                    print("touch began heart left")
                    originalPosition = CGPoint(x: -413.096, y: -3456.368)
                    heartLeft?.zPosition = 6
                    isDragHeartLeft = true
                } else if node == heartRight && heartRightLocked == false {
                    print("touch began heart right")
                    originalPosition = CGPoint(x: 402, y: -3456.169)
                    heartRight?.zPosition = 6
                    isDragHeartRight = true
                } else {
                    print ("nil")
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = isDragHeartLeft ? heartLeft : (isDragHeartRight ? heartRight : nil) {
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
                if location.x > -85 && location.x < 125 && location.y < -3370 {
                    // Switch to the next node
                    if node == heartLeft {
                        HapticUtils.hapticHug()
                        print ("drop heartLeft berhasil")
                        node.position = CGPoint(x: -73.4, y: -3456.369)
                        heartLeftLocked = true
                        if heartLeftLocked == true {
                            print ("heartleft locked")
                            isDragHeartLeft = false
                            heartLeft?.zPosition = 5
                            maskAnimation()
                        }
                    } else if node == heartRight {
                        HapticUtils.hapticHug()
                        print ("drop heartRight berhasil")
                        node.position = CGPoint(x: 59.63, y: -3457.019)
                        heartRightLocked = true
                        if heartRightLocked == true {
                            print ("heartright locked")
                            isDragHeartRight = false
                            heartRight?.zPosition = 5
                            maskAnimation()
                        }
                    }}
                else {
                    // If the touch location is not within the specified area, return the node to its original position
                    HapticUtils.hapticIde()
                    print("drop failed")

                    if node == heartLeft && heartLeftLocked == false {
                        originalPositionLeft = CGPoint(x: -413.096, y: -3456.368)
                        isDragHeartLeft = false
                        heartLeft?.zPosition = 5
                        node.position = originalPositionLeft!
                    } else if node == heartRight && heartRightLocked == false {
                        print("touch began heart right")
                        originalPositionRight = CGPoint(x: 402, y: -3456.169)
                        isDragHeartRight = false
                        heartRight?.zPosition = 5
                        node.position = originalPositionRight!
                    }
                }
            }
            
        }
    }
}
