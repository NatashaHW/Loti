import SpriteKit
import GameplayKit


class Scene1_Loti: SKScene {
    
    var phoneAlarm: SKSpriteNode?
    var vibrating = false
    
    var scene1SleepBNW: SKSpriteNode?
    var scene1SleepColor = SKSpriteNode(imageNamed: "sceneBiru")
    var scene1Yawn1: SKSpriteNode?
    var scene1Yawn2: SKSpriteNode?
    
    var scene1ChatBNW: SKSpriteNode?
    var scene1ChatOrange: SKSpriteNode?
    var scene1ChatYellow: SKSpriteNode?
    var scene1ChatBlue: SKSpriteNode?
    
    var emotionOrange: SKSpriteNode?
    var emotionYellow: SKSpriteNode?
    var emotionBlue: SKSpriteNode?
    
    var bubbleOrange1: SKSpriteNode?
    var bubbleYellow1: SKSpriteNode?
    var bubbleBlue1: SKSpriteNode?
    
    var friendsBubble0: SKSpriteNode?
    var friendsBubble1: SKSpriteNode?
    
    var bubbleOrange2: SKSpriteNode?
    var bubbleYellow2: SKSpriteNode?
    var bubbleBlue2: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
    
    var tapCountOrange = 0
    var tapCountYellow = 0
    var tapCountBlue = 0
    
    var emotionSelected = false
    
    var cropNode: SKCropNode!
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mendapatkan referensi ke node
        phoneAlarm = childNode(withName: "//scene1PhoneAlarm") as? SKSpriteNode
        
        scene1SleepBNW = childNode(withName: "//scene1SleepBNW") as? SKSpriteNode
        scene1Yawn1 = childNode(withName: "//scene1Yawn1") as? SKSpriteNode
        scene1Yawn2 = childNode(withName: "//scene1Yawn2") as? SKSpriteNode
        
        scene1ChatBNW = childNode(withName: "//scene1ChatBNW") as? SKSpriteNode
        scene1ChatOrange = childNode(withName: "//scene1ChatOrange") as? SKSpriteNode
        scene1ChatYellow = childNode(withName: "//scene1ChatYellow") as? SKSpriteNode
        scene1ChatBlue = childNode(withName: "//scene1ChatBlue") as? SKSpriteNode
        
        emotionOrange = childNode(withName: "//emotionOrange") as? SKSpriteNode
        emotionYellow = childNode(withName: "//emotionYellow") as? SKSpriteNode
        emotionBlue = childNode(withName: "//emotionBlue") as? SKSpriteNode
        
        bubbleOrange1 = childNode(withName: "//bubbleOrange1") as? SKSpriteNode
        bubbleYellow1 = childNode(withName: "//bubbleYellow1") as? SKSpriteNode
        bubbleBlue1 = childNode(withName: "//bubbleBlue1") as? SKSpriteNode
        
        friendsBubble0 = childNode(withName: "//friendsBubble0") as? SKSpriteNode
        friendsBubble1 = childNode(withName: "//friendsBubble1") as? SKSpriteNode
        
        bubbleOrange2 = childNode(withName: "//bubbleOrange2") as? SKSpriteNode
        bubbleYellow2 = childNode(withName: "//bubbleYellow2") as? SKSpriteNode
        bubbleBlue2 = childNode(withName: "//bubbleBlue2") as? SKSpriteNode
        
        // Set initial state
        scene1Yawn2?.isHidden = true
        scene1ChatOrange?.isHidden = true
        scene1ChatYellow?.isHidden = true
        scene1ChatBlue?.isHidden = true
        
        bubbleOrange1?.isHidden = true
        bubbleYellow1?.isHidden = true
        bubbleBlue1?.isHidden = true
        
        friendsBubble0?.isHidden = true
        friendsBubble1?.isHidden = true
        
        bubbleOrange2?.isHidden = true
        bubbleYellow2?.isHidden = true
        bubbleBlue2?.isHidden = true
        
        //alarm
        vibrateAlarm()
        print("\(vibrating)")
        
        cropNode = SKCropNode()
        addChild(cropNode)
        //reposition and rescale scene1sleepcolor
        scene1SleepColor.position = CGPoint(x: frame.midX, y: frame.midY + 70)
        scene1SleepColor.size = CGSize(width: 1179, height: 2421)
        
        //buat shape lingkaran utk mask
        let maskNode = SKShapeNode(circleOfRadius: 100)
        maskNode.fillColor = .black
        maskNode.position = CGPoint(x:self.phoneAlarm!.position.x, y:self.phoneAlarm!.position.y)
        
        cropNode.maskNode = maskNode
        cropNode.zPosition = 1

        // Add scene1SleepColor to crop node
        cropNode.addChild(scene1SleepColor)
        
        // Hide scene1SleepColor initially
        scene1SleepBNW?.isHidden = false
        
    }
    
    func animateMask() {
        let mask = cropNode.maskNode as? SKShapeNode
        if vibrating==false {
            // Enlarge the mask node when not vibrating
            mask?.run(SKAction.scale(to: 20, duration: 1))
            print("tes animation mask")
        }
    }
    

    func vibrateAlarm() {
         if let alarm = phoneAlarm {
             let delay = SKAction.wait(forDuration: 0.5)
            
             // Update vibrating to true when starting vibration
             vibrating = true
             
             let startVibrationAction = SKAction.run {
                 self.startVibration()
             }
             alarm.run(SKAction.sequence([delay, startVibrationAction]))
         }
     }
    
    func startVibration() {
        guard let alarm = phoneAlarm else { return }
        alarm.zRotation = 0.5
        
        let rotateClockwise = SKAction.rotate(byAngle: CGFloat.pi/15.0, duration: 0.1)
        let rotateAntiClockwise = SKAction.rotate(byAngle: -CGFloat.pi/15.0, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.2)
        
        let sequence = SKAction.sequence([rotateClockwise, rotateAntiClockwise, rotateClockwise, rotateAntiClockwise, wait])
        let repeatAction = SKAction.repeatForever(sequence)
        
        // Check if haptic feedback is running and start it
        if vibrating {
            HapticUtils.runHapticOnBackgroundThreadWithinInterval(seconds: 0.5)
        }
            
        // Run animation on the alarm asset
        alarm.run(repeatAction){}
    }

    func stopVibration() {
        guard let alarm = phoneAlarm else { return }
        
        // Stop all animations running on the alarm asset
        alarm.removeAllActions()
        
        // Update the vibrating status and animate the mask
        vibrating = false
        animateMask()
        
        HapticUtils.stopHaptic()
    }

    
    // Function untuk menangani ketika asset alarm ditekan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first {
                if node == phoneAlarm && vibrating == true {
                    stopVibrationAndMoveCamera()
                }
            }
        }
    }
    
    func stopVibrationAndMoveCamera() {
        stopVibration()

        // Menunggu 2 detik
        let waitDuration = SKAction.wait(forDuration: 2.0)
        
        // Menggerakkan kamera ke scene1Yawn1
        let moveCameraAction = SKAction.move(to: scene1Yawn1!.position, duration: 1.0)
        cameraNode?.run(SKAction.sequence([waitDuration, moveCameraAction]))
        
        // Menampilkan scene1Yawn2 setelah menunggu 0.8 detik
        let showScene1Yawn2Action = SKAction.run {
            self.scene1Yawn2?.isHidden = false
        }
        let waitToShowScene1Yawn2 = SKAction.wait(forDuration: 0.8)
        let sequenceToShowScene1Yawn2 = SKAction.sequence([waitToShowScene1Yawn2, showScene1Yawn2Action])
        run(sequenceToShowScene1Yawn2)
        
        // Menggerakkan kamera ke scene1ChatBNW setelah menunggu 0.8 detik lagi
        let moveCameraToChatAction = SKAction.move(to: scene1ChatBNW!.position, duration: 1.0)
        let waitBeforeMoveCameraToChat = SKAction.wait(forDuration: 0.8)
        let sequenceMoveCameraToChat = SKAction.sequence([waitBeforeMoveCameraToChat, moveCameraToChatAction])
        cameraNode?.run(sequenceMoveCameraToChat)
    }

}
