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
    
    var newBubbleOrange: SKSpriteNode!
    var newBubbleYellow: SKSpriteNode!
    var newBubbleBlue: SKSpriteNode!
    // Properti untuk gelembung teman
    var newFriendBubble0: SKSpriteNode!
    var newFriendBubble1: SKSpriteNode!
    
    var allBubbles = [SKSpriteNode]()
    var allFriendBubbles = [SKSpriteNode]()
    
    //    var bubbleOrange = SKSpriteNode(imageNamed: "Bubble Oranye")
    //    var bubbleYellow = SKSpriteNode(imageNamed: "Bubble Kuning")
    //    var bubbleBlue = SKSpriteNode(imageNamed: "Bubble Biru")
    //    var friendBubble0 = SKSpriteNode(imageNamed: "Bubble Temen Biru")
    //    var friendBubble1 = SKSpriteNode(imageNamed: "Bubble Temen Kuning")
    
    var cameraNode: SKCameraNode?
    
    var bubbleYPosition: CGFloat = -3800
    var friendBubbleYPosition: CGFloat = -3600
    
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
        
        
        // Set initial state
        scene1Yawn2?.isHidden = true
        scene1ChatOrange?.isHidden = true
        scene1ChatYellow?.isHidden = true
        scene1ChatBlue?.isHidden = true
        
        //alarm
        vibrateAlarm()
        
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
    
    
    func createNewBubbleOrange() -> SKSpriteNode {
        let newBubbleOrange = SKSpriteNode(imageNamed: "Bubble Oranye")
        newBubbleOrange.zPosition = 40
        return newBubbleOrange
    }
    
    func createNewBubbleYellow() -> SKSpriteNode {
        let newBubbleYellow = SKSpriteNode(imageNamed: "Bubble Kuning")
        newBubbleYellow.zPosition = 40
        return newBubbleYellow
    }
    
    func createNewBubbleBlue() -> SKSpriteNode {
        let newBubbleBlue = SKSpriteNode(imageNamed: "Bubble Biru")
        newBubbleBlue.zPosition = 40
        return newBubbleBlue
    }
    
    func createNewFriendBubble0() -> SKSpriteNode {
        let newFriendBubble0 = SKSpriteNode(imageNamed: "Bubble Temen Biru")
        newFriendBubble0.zPosition = 40
        return newFriendBubble0
    }
    
    func createNewFriendBubble1() -> SKSpriteNode {
        let newFriendBubble1 = SKSpriteNode(imageNamed: "Bubble Temen Kuning")
        newFriendBubble1.zPosition = 40
        return newFriendBubble1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first {
                if node == phoneAlarm && vibrating == true {
                    stopVibrationAndMoveCamera()
                } else if node == emotionOrange {
                    tapCountOrange += 1
                    print("tap count orange", tapCountOrange)
                    animateVibration(for: emotionOrange)
                    
                    scene1ChatOrange?.isHidden = false
                    
                    let newBubbleOrange = createNewBubbleOrange()
                    showBubbleAndFriendsBubble(bubble: newBubbleOrange)
                } else if node == emotionYellow {
                    tapCountYellow += 1
                    print("tap count yellow", tapCountYellow)
                    animateVibration(for: emotionYellow)
                    
                    scene1ChatYellow?.isHidden = false
                    
                    let newBubbleYellow = createNewBubbleYellow()
                    showBubbleAndFriendsBubble(bubble: newBubbleYellow)
                } else if node == emotionBlue  {
                    tapCountBlue += 1
                    print("tap count blue", tapCountBlue)
                    animateVibration(for: emotionBlue)
                    
                    scene1ChatBlue?.isHidden = false
                    
                    let newBubbleBlue = createNewBubbleBlue()
                    showBubbleAndFriendsBubble(bubble: newBubbleBlue)
                }
            }
        }
    }
    
    
    func stopVibrationAndMoveCamera() {
        stopVibration()
        let waitToShowScene1Yawn1 = SKAction.wait(forDuration: 2.0)
        // Menggerakkan kamera ke scene1Yawn1
        let moveCameraToYawn1Action = SKAction.move(to: scene1Yawn1!.position, duration: 1.0)
        let sequenceToShowScene1Yawn1 = SKAction.sequence([waitToShowScene1Yawn1, moveCameraToYawn1Action])
        
        // Menampilkan scene1Yawn2 setelah menunggu 0.8 detik
        let showScene1Yawn2Action = SKAction.run {
            self.scene1Yawn2?.isHidden = false
        }
        let waitToShowScene1Yawn2 = SKAction.wait(forDuration: 0.8)
        let sequenceToShowScene1Yawn2 = SKAction.sequence([waitToShowScene1Yawn2, showScene1Yawn2Action])
        
        // Menggerakkan kamera ke scene1ChatBNW setelah menunggu 1.8 detik
        let moveCameraToChatAction = SKAction.move(to: scene1ChatBNW!.position, duration: 1.0)
        let waitBeforeMoveCameraToChat = SKAction.wait(forDuration: 1.8)
        let sequenceMoveCameraToChat = SKAction.sequence([waitBeforeMoveCameraToChat, moveCameraToChatAction])
        
        // Menjalankan urutan aksi
        cameraNode?.run(SKAction.sequence([sequenceToShowScene1Yawn1, sequenceToShowScene1Yawn2, sequenceMoveCameraToChat]))
    }
    
    
    func showBubbleAndFriendsBubble(bubble: SKSpriteNode?) {
        guard let bubble = bubble else { return }
        
        // Menampilkan gelembung baru pada posisi awal
        bubble.position = CGPoint(x: -233, y: -3650)
        addChild(bubble)
        
        // Menunggu selama 1.5 detik sebelum menampilkan gelembung teman
        let waitToShowFriendsBubble = SKAction.wait(forDuration: 0.2)
        
        // Menggeser gelembung dan gelembung teman setelah menunggu 1.5 detik
        let moveUpAction = SKAction.moveBy(x: 0, y: 200, duration: 0.3)
        let moveUpActionForFriends = SKAction.moveBy(x: 0, y: 500, duration: 0.3)
        let moveUpSequence = SKAction.sequence([waitToShowFriendsBubble, moveUpAction])
        
        // Menjalankan urutan aksi untuk gelembung baru
        bubble.run(moveUpSequence) {
            // Menampilkan gelembung teman setelah gelembung baru digeser
            let friendsBubbleIndex = Int.random(in: 0...1)
            if friendsBubbleIndex == 0 {
                let newFriendBubble0 = self.createNewFriendBubble0()
                newFriendBubble0.position = CGPoint(x: -233, y: -3700)
                self.addChild(newFriendBubble0)
                self.allFriendBubbles.append(newFriendBubble0)
                self.scene1ChatBlue?.isHidden = false
            } else {
                let newFriendBubble1 = self.createNewFriendBubble1()
                newFriendBubble1.position = CGPoint(x: -233, y: -3700)
                self.addChild(newFriendBubble1)
                self.allFriendBubbles.append(newFriendBubble1)
                self.scene1ChatYellow?.isHidden = false
            }
        }
        
        // Menggeser semua gelembung dan gelembung teman setelah menunggu 1.5 detik
        for existingBubble in allBubbles {
            existingBubble.run(moveUpActionForFriends)
            // Periksa apakah gelembung telah mencapai batas atas layar
            if existingBubble.position.y >= frame.maxY {
                // Hapus gelembung dari tampilan dan dari daftar
                existingBubble.removeFromParent()
                if let index = allBubbles.firstIndex(of: existingBubble) {
                    allBubbles.remove(at: index)
                }
            }
        }
        
        for friendBubble in allFriendBubbles {
            friendBubble.run(moveUpActionForFriends)
            // Periksa apakah gelembung teman telah mencapai batas atas layar
            if friendBubble.position.y >= frame.maxY {
                // Hapus gelembung teman dari tampilan dan dari daftar
                friendBubble.removeFromParent()
                if let index = allFriendBubbles.firstIndex(of: friendBubble) {
                    allFriendBubbles.remove(at: index)
                }
            }
        }
        
        allBubbles.append(bubble)
    }


    
    
    func animateVibration(for node: SKSpriteNode?) {
        guard let node = node else { return }
        let rotateRight = SKAction.rotate(byAngle: CGFloat.pi / 18, duration: 0.05)
        let rotateLeft = SKAction.rotate(byAngle: -CGFloat.pi / 18, duration: 0.05)
        let sequence = SKAction.sequence([rotateRight, rotateLeft])
        let repeatAction = SKAction.repeat(sequence, count: 4)
        node.run(repeatAction)
    }
    
    
}
