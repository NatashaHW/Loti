import SpriteKit

class Scene5_Fighting: SKScene {
    
    var handBefore: SKSpriteNode?
    var handAfter: SKSpriteNode?
    var bgFight1: SKSpriteNode?
    var bgFight2: SKSpriteNode?
    var bgFight3: SKSpriteNode?
    var lilo1: SKSpriteNode?
    var lilo2: SKSpriteNode?
    var lilo3: SKSpriteNode?
    var leftPH: SKSpriteNode?
    var middlePH: SKSpriteNode?
    var rightPH: SKSpriteNode?
    
    var bubbleBlue: SKSpriteNode?
    var bubbleRed1: SKSpriteNode?
    var bubbleRed2: SKSpriteNode?
    var bubbleRed3: SKSpriteNode?
    var bubbleRed4: SKSpriteNode?
    var bubbleRed5: SKSpriteNode?
    var bubbleRed6: SKSpriteNode?
    
    var score: Int = 0
    
//    var sceneTengkar: SKAudioNode!
    
    var canSpawnButton: Bool = true
    
    var cameraNode: SKCameraNode?
    
    // Variabel untuk menyimpan posisi awal sentuhan pada button
    var initialTouchPosition: CGPoint?
    
    // Batasan geseran button di sisi kanan dan kiri layar
    let maxLeftPosition: CGFloat = 20
    let maxRightPosition: CGFloat = UIScreen.main.bounds.width - 20 // Menggunakan lebar layar
    
    // Haptic generator
//    let hapticGenerator = UIImpactFeedbackGenerator(style: .rigid)
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mengambil node dari scene
        handBefore = childNode(withName: "//handBefore") as? SKSpriteNode
        handAfter = childNode(withName: "//handAfter") as? SKSpriteNode
        bgFight1 = childNode(withName: "//bgFight1") as? SKSpriteNode
        bgFight2 = childNode(withName: "//bgFight2") as? SKSpriteNode
        bgFight3 = childNode(withName: "//bgFight3") as? SKSpriteNode
        lilo1 = childNode(withName: "//lilo1") as? SKSpriteNode
        lilo2 = childNode(withName: "//lilo2") as? SKSpriteNode
        lilo3 = childNode(withName: "//lilo3") as? SKSpriteNode
        leftPH = childNode(withName: "//leftPH") as? SKSpriteNode
        middlePH = childNode(withName: "//middlePH") as? SKSpriteNode
        rightPH = childNode(withName: "//rightPH") as? SKSpriteNode
        bubbleBlue = childNode(withName: "//bubbleBlue") as? SKSpriteNode
        bubbleRed1 = childNode(withName: "//bubbleRed1") as? SKSpriteNode
        bubbleRed2 = childNode(withName: "//bubbleRed2") as? SKSpriteNode
        bubbleRed3 = childNode(withName: "//bubbleRed3") as? SKSpriteNode
        bubbleRed4 = childNode(withName: "//bubbleRed4") as? SKSpriteNode
        bubbleRed5 = childNode(withName: "//bubbleRed5") as? SKSpriteNode
        bubbleRed6 = childNode(withName: "//bubbleRed6") as? SKSpriteNode
        
        
        // Sembunyikan scene4_envy2 dan tunjukkan scene4_envy1
        handBefore?.isHidden = false
        handAfter?.isHidden = true
        bgFight1?.isHidden = false
        bgFight2?.isHidden = true
        bgFight3?.isHidden = true
        lilo1?.isHidden = false
        lilo2?.isHidden = true
        lilo3?.isHidden = true
        leftPH?.isHidden = false
        middlePH?.isHidden = false
        rightPH?.isHidden = false
        bubbleBlue?.isHidden = true
        bubbleRed1?.isHidden = true
        bubbleRed2?.isHidden = true
        bubbleRed3?.isHidden = true
        bubbleRed4?.isHidden = true
        bubbleRed5?.isHidden = true
        bubbleRed6?.isHidden = true
        
//        sceneTengkar = playBackgroundMusic(musicName: "SceneTengkar")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.handAfter?.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            if let bgFight1 = self.bgFight1 {
                let moveAction = SKAction.move(to: bgFight1.position, duration: 1.5)
                self.cameraNode?.run(moveAction)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                
                // Unhide bubbleblue
                self.bubbleBlue?.isHidden = false
                
                // Move bubbleblue up a little
                let moveUpAction = SKAction.moveBy(x: 0, y: 50, duration: 0.3)
                self.bubbleBlue?.run(moveUpAction)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    // Start spawning water if canSpawnWater is true
                    if self.canSpawnButton {
                        self.spawnButtons()
                    }
                }
            }
        }
        
        
    }
    
    
    func spawnButtons() {
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(spawnSingleButton),
            SKAction.wait(forDuration: 1.0)
        ])))
    }
    
    func spawnSingleButton() {
        let buttonIndex = Int.random(in: 1...3)
        let button = SKSpriteNode(imageNamed: "button\(buttonIndex)")
        button.name = "button"
        
        if buttonIndex == 1 {
            button.position = CGPoint(x: -400.5, y: -3425.302)
        } else if buttonIndex == 2 {
            button.position = CGPoint(x: 0, y: -3415.302)
        } else if buttonIndex == 3 {
            button.position = CGPoint(x: 384, y: -3429.802)
        }
        
        button.zPosition = 30
        
        addChild(button)
        
        let waitTime = SKAction.wait(forDuration: 1.5)
        let removeAction = SKAction.removeFromParent()
        button.run(SKAction.sequence([waitTime, removeAction]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        
        // Cek apakah sentuhan terjadi di air
        let touchedNode = atPoint(touchLocation)
        if touchedNode.name == "button" {
            touchedNode.removeFromParent()
            score += 1
            
            switch score {
            case 1:
                self.bubbleRed1?.isHidden = false
            case 2:
                self.bubbleRed2?.isHidden = false
            case 3:
                self.bubbleRed3?.isHidden = false
                bgFight2?.isHidden = false
                lilo2?.isHidden = false
            case 4:
                self.bubbleRed4?.isHidden = false
            case 5:
                self.bubbleRed5?.isHidden = false
//                stopBackgroundMusicWithFadeOut(music: sceneTengkar)
            case 6:
                self.bubbleRed6?.isHidden = false
                canSpawnButton = false
                bgFight3?.isHidden = false
                lilo3?.isHidden = false
                
                self.removeAllActions()
                
//                self.sceneTengkar.run(SKAction.stop())
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.stopBackgroundMusicWithFadeOut(music: self.sceneTengkar)
                    
                    if let scene6 = Scene6_Sadness(fileNamed: "Scene6_Sadness") {
                        // Setup scene yang baru
                        scene6.scaleMode = .aspectFill
                        // Transisi ke scene baru
                        self.view?.presentScene(scene6, transition: SKTransition.push(with: .up, duration: 2.0))
                    }
                }
            default:
                break
            }
            
            // Berikan umpan balik haptik yang kuat setiap kali tombol ditekan
            HapticUtils.hapticHug()
            
        }
        
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
