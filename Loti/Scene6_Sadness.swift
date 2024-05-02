import SpriteKit

class Scene6_Sadness: SKScene {
    
    var sadBefore: SKSpriteNode?
    var sadAfter: SKSpriteNode?
    var cryAfter: SKSpriteNode?
    var cryBefore: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
    
    var score: Int = 0
    
    var Sad: SKAudioNode!
    
    var canSpawnWater: Bool = true // Variabel untuk menandai apakah air masih boleh di-spawn
    
    let hapticGenerator = UIImpactFeedbackGenerator(style: .rigid)
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mengambil node dari scene
        sadBefore = childNode(withName: "//sadBefore") as? SKSpriteNode
        sadAfter = childNode(withName: "//sadAfter") as? SKSpriteNode
        cryAfter = childNode(withName: "//cryAfter") as? SKSpriteNode
        cryBefore = childNode(withName: "//cryBefore") as? SKSpriteNode
        
        sadBefore?.isHidden = false
        sadAfter?.isHidden = true
        cryAfter?.isHidden = true
        cryBefore?.isHidden = false
        
        Sad = playBackgroundMusic(musicName: "Sad")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sadAfter?.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            if let cryBefore = self.cryBefore {
                let moveAction = SKAction.move(to: cryBefore.position, duration: 1.5)
                self.cameraNode?.run(moveAction)
                
                // Start spawning water if canSpawnWater is true
                if self.canSpawnWater {
                    self.spawnWater()
                }
            }
        }
        
    }
    
    func spawnWater() {
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(spawnSingleWater),
            SKAction.wait(forDuration: 1.0)
        ])))
    }
    
    func spawnSingleWater() {
        let waterIndex = Int.random(in: 1...2)
        let water = SKSpriteNode(imageNamed: "water\(waterIndex)")
        water.name = "water"
        
        let randomX = CGFloat.random(in: -size.width/2...size.width/2)
        let waterY = size.height/2 + water.size.height/2
        water.position = CGPoint(x: randomX, y: waterY)
        water.zPosition = 30
        water.setScale(1.5)
        
        addChild(water)
        
        let moveAction = SKAction.moveTo(y: (-size.height/2 - water.size.height) * 3, duration: 6.0)
        let removeAction = SKAction.removeFromParent()
        water.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mendapatkan lokasi sentuhan
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Cek apakah sentuhan terjadi di air
        let touchedNode = atPoint(touchLocation)
        if touchedNode.name == "water" {
            touchedNode.removeFromParent()
            score += 1
            print("Score:", score)
            
            hapticGenerator.impactOccurred()
            
            print(score)
            
            // Cek apakah sudah mencapai skor 10
            if score == 10 {
                canSpawnWater = false // Setel variabel untuk tidak lagi bisa spawn air
                cryAfter?.isHidden = false
                
                // Menghentikan semua aksi yang diulang, termasuk spawnWater()
                self.removeAllActions()
                
                stopBackgroundMusicWithFadeOut(music: Sad)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let scene7 = Scene7_Hug(fileNamed: "Scene7_Hug") {
                        // Setup scene yang baru
                        scene7.scaleMode = .aspectFill
                        // Transisi ke scene baru
                        self.view?.presentScene(scene7, transition: SKTransition.push(with: .up, duration: 2.0))
                    }
                }
            }
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
