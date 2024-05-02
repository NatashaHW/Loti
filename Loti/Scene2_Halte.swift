import SpriteKit

class Scene2_Halte: SKScene {
    
    var scene2BNW1: SKSpriteNode?
    var scene2BNW2: SKSpriteNode?
    var scene2Color1: SKSpriteNode?
    var scene2Color2: SKSpriteNode?
    var scene2Instruction: SKSpriteNode?
    var scene2ClockHand: SKSpriteNode?
    var scene2Clock: SKSpriteNode?
    var scene2BgClock: SKSpriteNode?
    var scene2Hand: SKSpriteNode?
    
    var bgHalte: SKSpriteNode?
    var bubbleBlue1: SKSpriteNode?
    var bubbleRed1: SKSpriteNode?
    var bubbleRed2: SKSpriteNode?
    var bubbleRed3: SKSpriteNode?
    var bubbleRed4: SKSpriteNode?
    
    var radarJam: SKSpriteNode?
    
    var clockTicking: SKAudioNode!
    
    var bubbleRed1Tap: SKSpriteNode?
    var bubbleRed2Tap: SKSpriteNode?
    var bubbleRed3Tap: SKSpriteNode?
    var bubbleRed4Tap: SKSpriteNode?
    
    var busBSD: SKSpriteNode?
    
    var isScene2ClockHandRotating = false
    var cameraNode: SKCameraNode?
    
    var tapCount = 0
    var swipeCount = 0
    
    var arrowUp: SKSpriteNode?
    
    var halteSound: SKAudioNode!
    
    // Create a feedback generator instance for selection feedback
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mengambil node dari scene
        scene2BNW1 = childNode(withName: "//scene2BNW1") as? SKSpriteNode
        scene2BNW2 = childNode(withName: "//scene2BNW2") as? SKSpriteNode
        scene2Color1 = childNode(withName: "//scene2Color1") as? SKSpriteNode
        scene2Color2 = childNode(withName: "//scene2Color2") as? SKSpriteNode
        scene2ClockHand = childNode(withName: "//scene2ClockHand") as? SKSpriteNode
        scene2Clock = childNode(withName: "//scene2Clock") as? SKSpriteNode
        scene2BgClock = childNode(withName: "//scene2BgClock") as? SKSpriteNode
        scene2Hand = childNode(withName: "//scene2Hand") as? SKSpriteNode
        
        bgHalte = childNode(withName: "//bgHalte") as? SKSpriteNode
        bubbleBlue1 = childNode(withName: "//bubbleBlue1") as? SKSpriteNode
        bubbleRed1 = childNode(withName: "//bubbleRed1") as? SKSpriteNode
        bubbleRed2 = childNode(withName: "//bubbleRed2") as? SKSpriteNode
        bubbleRed3 = childNode(withName: "//bubbleRed3") as? SKSpriteNode
        bubbleRed4 = childNode(withName: "//bubbleRed4") as? SKSpriteNode
        
        bubbleRed1Tap = childNode(withName: "//bubbleRed1Tap") as? SKSpriteNode
        bubbleRed2Tap = childNode(withName: "//bubbleRed2Tap") as? SKSpriteNode
        bubbleRed3Tap = childNode(withName: "//bubbleRed3Tap") as? SKSpriteNode
        bubbleRed4Tap = childNode(withName: "//bubbleRed4Tap") as? SKSpriteNode
        
        radarJam = childNode(withName: "//radarJam") as? SKSpriteNode
        arrowUp = childNode(withName: "//arrowUp") as? SKSpriteNode
        
        busBSD = childNode(withName: "busBSD") as? SKSpriteNode
        
        // Sembunyikan node yang tidak terlihat pada awalnya
        scene2BNW2?.isHidden = true
        scene2Color1?.isHidden = true
        scene2Color2?.isHidden = true
        scene2ClockHand?.isHidden = true
        scene2Clock?.isHidden = true
        scene2BgClock?.isHidden = true
        scene2Hand?.isHidden = true
        
        bubbleBlue1?.isHidden = true
        bubbleRed1?.isHidden = true
        bubbleRed2?.isHidden = true
        bubbleRed3?.isHidden = true
        bubbleRed4?.isHidden = true
        bubbleRed1Tap?.isHidden = true
        bubbleRed2Tap?.isHidden = true
        bubbleRed3Tap?.isHidden = true
        bubbleRed4Tap?.isHidden = true
        radarJam?.isHidden = true
        arrowUp?.isHidden = true
        
        self.clockTicking = self.playBackgroundMusic(musicName: "Clock Tick Edit")
        
        halteSound = playBackgroundMusic(musicName: "AnxiousHalte")
        
        // Mulai animasi setelah beberapa detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.scene2BNW2?.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            // Unhide dengan transition slide dari kanan ke kiri
            let slideDistance = self.size.width // Jarak pergeseran
            let slideLeftAction = SKAction.moveBy(x: -slideDistance, y: 0, duration: 0.5) // Menggeser ke kiri sejauh slideDistance dalam 0.5 detik
            self.scene2ClockHand?.run(slideLeftAction)
            self.radarJam?.run(slideLeftAction)
            self.scene2Clock?.run(slideLeftAction)
            self.scene2BgClock?.run(slideLeftAction)
            self.scene2Hand?.run(slideLeftAction)
            
            self.scene2ClockHand?.isHidden = false
            self.radarJam?.isHidden = false
            self.scene2Clock?.isHidden = false
            self.scene2BgClock?.isHidden = false
            self.scene2Hand?.isHidden = false
            self.arrowUp?.isHidden = false
            self.animateUpAndDown(object: self.arrowUp!)
        }
        
    }
    
    func setupSwipeGestureRecognizer() {
        // Add the swipe gesture recognizer to the view
        print ("swipe gesture setup")
        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        upSwipeGestureRecognizer.direction = .up
        upSwipeGestureRecognizer.numberOfTouchesRequired = 1
        view?.addGestureRecognizer(upSwipeGestureRecognizer)
    }
    
    // Override touchesBegan method to handle touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mendapatkan lokasi sentuhan saat ini
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        //set up touch gesture
        if tapCount == 10 {
            setupSwipeGestureRecognizer()
        }
        
        // Cek apakah sentuhan terjadi di area scene2Clock atau scene2ClockHand
        if let clock = scene2Clock, clock.contains(touchLocation) {
            // Memulai rotasi scene2ClockHand searah jarum jam
            rotateClockHandClockwise()
            tapCount += 1
            // Provide impact haptic feedback
            impactFeedbackGenerator.impactOccurred()
            print ("\(tapCount)")
            
            
        } else if let clockHand = scene2ClockHand, clockHand.contains(touchLocation) {
            // Memulai rotasi scene2ClockHand searah jarum jam
            rotateClockHandClockwise()
            tapCount += 1
            // Provide impact haptic feedback
            impactFeedbackGenerator.impactOccurred()
            print ("\(tapCount)")
            
        }
        
        
        func rotateClockHandClockwise() {
            // Memeriksa apakah sudah ada rotasi yang sedang berlangsung
            guard !isScene2ClockHandRotating else { return }
            
            // Memulai animasi rotasi
            let rotateAction = SKAction.rotate(byAngle: -CGFloat.pi / 6, duration: 0.2) // Rotasi sebesar 30 derajat (π/6 radian) dalam 0.2 detik
            let rotateSequence = SKAction.sequence([rotateAction, SKAction.run {
                // Memeriksa apakah scene2ClockHand sudah berputar sebanyak 200 derajat
                if self.tapCount >= 5 && self.tapCount < 10 {
                    self.scene2Color1?.isHidden = false
                } else if self.tapCount == 10 {
                    self.scene2Color2?.isHidden = false
                } else if self.tapCount >= 11 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.cameraNode?.run(SKAction.move(to: CGPoint(x: self.bgHalte!.position.x, y: self.bgHalte!.position.y), duration: 1.0))
                        
                        // Menampilkan bubbleRed1 dan mengubah posisinya
                        self.bubbleRed1?.isHidden = false
                        self.bubbleRed1?.position = CGPoint(x: -12, y: -3540)
                        self.bubbleRed1?.zPosition = 35

                        
                        self.bubbleRed2?.position = CGPoint(x: 2, y: -3540)
                        self.bubbleRed2?.zPosition = 36
                        
                        self.bubbleRed3?.position = CGPoint(x: 8.65, y: -3540)
                        self.bubbleRed3?.zPosition = 37
                        
                        self.bubbleRed4?.position = CGPoint(x: 25.037, y: -3540)
                        self.bubbleRed4?.zPosition = 38

                        self.clockTicking.run(SKAction.stop())
                    }
                }
            }])
            
            // Menandai bahwa rotasi sedang berlangsung
            isScene2ClockHandRotating = true
            
            // Memulai animasi rotasi
            scene2ClockHand?.run(rotateSequence) {
                // Menandai bahwa rotasi telah selesai
                self.isScene2ClockHandRotating = false
            }
        }
        
        
        
    }
    
    @objc func swipeGesture (_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            print("Swipe detected")
            swipeCount += 1
            print("Swipe count: \(swipeCount)")
        
            let swipeLocation = recognizer.location(in: view)
            print ("\(swipeLocation)")
            
            switch swipeCount {
            case 1:
                // Tentukan posisi baru untuk bubbleRed1 setelah pergeseran
                let newPosition = CGPoint(x: -12, y: -1959.5)
                
                // Buat action untuk pergeseran ke atas
                let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
                
                bubbleRed1?.zPosition = 20
                arrowUp?.isHidden = true
                // Jalankan action pada bubbleRed1
                bubbleRed1?.run(slideUpAction) {
                    // Setelah pergeseran selesai, tunggu 0.1 detik
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // Tampilkan bubbleBlue1 setelah menunggu
                        self.bubbleBlue1?.isHidden = false
                    }
                    
                    // Tunggu 0.2 detik lebih lama
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        // Tampilkan bubbleRed2 setelah menunggu
                        self.bubbleRed2?.isHidden = false
                    }
                    // Provide impact haptic feedback
                    let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                    heavyImpactFeedbackGenerator.impactOccurred()
                }
                
            case 2:
                // Jika ini adalah swipe kedua
                // Tentukan posisi baru untuk bubbleRed2 setelah pergeseran kedua
                let newPosition = CGPoint(x: 222.537, y: -2301.2)
                
                // Buat action untuk pergeseran ke atas
                let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
                
                bubbleRed2?.zPosition = 19
                // Jalankan action pada bubbleRed2
                bubbleRed2?.run(slideUpAction)
                
                // Tunggu 0.2 detik lebih lama
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    // Tampilkan bubbleRed2 setelah menunggu
                    self.bubbleRed3?.isHidden = false
                }
                // Provide impact haptic feedback
                let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                heavyImpactFeedbackGenerator.impactOccurred()
                
            case 3:
                // Jika ini adalah swipe ketiga
                // Tentukan posisi baru untuk bubbleRed3 setelah pergeseran ketiga
                let newPosition = CGPoint(x: 193.187, y: -1832.604)
                
                // Buat action untuk pergeseran ke atas
                let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
                
                bubbleRed3?.zPosition = 20
                // Jalankan action pada bubbleRed3
                bubbleRed3?.run(slideUpAction)
                
                // Tunggu 0.2 detik lebih lama
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    // Tampilkan bubbleRed3 setelah menunggu
                    self.bubbleRed4?.isHidden = false
                }
                
                let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                heavyImpactFeedbackGenerator.impactOccurred()
                
            case 4:
                // Jika ini adalah swipe keempat
                // Tentukan posisi baru untuk bubbleRed3 setelah pergeseran ketiga
                let newPosition = CGPoint(x: 235.5, y: -2054.918)
                
                // Buat action untuk pergeseran ke atas
                let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
                
                bubbleRed4?.zPosition = 21
                bubbleRed4?.run(slideUpAction)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    // Unhide dengan transition slide dari kanan ke kiri
                    /*let slideDistance = self.size.width*/ // Jarak pergeseran
                    let slideTo = CGPoint(x: 3.367, y: -2906.954)
                    let slideRightAction = SKAction.move(to: slideTo, duration: 2.5)
                    // Terapkan timing mode ease in pada slideRightAction
                    slideRightAction.timingMode = .easeIn
                    
                    self.busBSD?.run(slideRightAction) {
                        // Navigasi ke Scene3_Diskusi setelah animasi selesai
                        self.halteSound.run(SKAction.stop())
                        if let scene3Diskusi = Scene3_Diskusi(fileNamed: "Scene3_Diskusi") {
                            scene3Diskusi.scaleMode = .aspectFill
                            self.view?.presentScene(scene3Diskusi)
                        }
                    }
                }
                
                let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                heavyImpactFeedbackGenerator.impactOccurred()
                
            default:
                break
            }
            
        }
        
    }
    
    func animateUpAndDown(object: SKSpriteNode) {
        // Pastikan object tidak sedang disembunyikan
        guard !object.isHidden else { return }
        
        // Tentukan posisi tujuan baru saat naik dan saat turun
        let upPosition = CGPoint(x: object.position.x, y: object.position.y + 20)
        let downPosition = CGPoint(x: object.position.x, y: object.position.y)
        
        // Buat action untuk menggerakkan node ke posisi baru saat naik dan saat turun
        let moveUpAction = SKAction.move(to: upPosition, duration: 0.5)
        let moveDownAction = SKAction.move(to: downPosition, duration: 0.5)
        
        // Gabungkan kedua action dalam sebuah sequence
        let upAndDownSequence = SKAction.sequence([moveUpAction, moveDownAction])
        
        // Buat action untuk mengulangi sequence tersebut
        let repeatAction = SKAction.repeatForever(upAndDownSequence)
        
        // Jalankan action pada arrowUp
        object.run(repeatAction)
    }


    
    func playBackgroundMusic(musicName: String) -> SKAudioNode? {
            // Mencari URL musik dengan menggunakan nama file
            guard let musicURL = Bundle.main.url(forResource: musicName, withExtension: "mp3") else {
                print("Background music file not found.")
                return nil
            }
            
            // Membuat audio node dari URL dan mengembalikannya
            let music = SKAudioNode(url: musicURL)
            addChild(music)
            return music
        }
    
    func stopBackgroundMusicWithFadeOut(music: SKAudioNode?) {
        guard let music = music else { return }
        
        let fadeOutDuration: TimeInterval = 40.0 // Durasi fade-out
        let fadeSteps: Int = 100 // Jumlah langkah dalam fade-out
        let initialVolume: Float = 0.5 // Volume awal

        // Menghitung penurunan volume pada setiap langkah
        let volumeStep = initialVolume / Float(fadeSteps)

        // Membuat serangkaian aksi untuk mengurangi volume secara perlahan
        var fadeOutActions: [SKAction] = []
        for step in 1...fadeSteps {
            let volume = initialVolume - Float(step) * volumeStep
            let changeVolumeAction = SKAction.changeVolume(to: volume, duration: fadeOutDuration / Double(fadeSteps))
            fadeOutActions.append(changeVolumeAction)
        }

        // Menjalankan efek fade-out pada audio node
        music.run(SKAction.sequence(fadeOutActions)) {
            music.run(SKAction.stop())
        }
    }
}
