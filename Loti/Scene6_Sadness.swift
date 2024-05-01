import SpriteKit

class Scene6_Sadness: SKScene {
    
    var sadBefore: SKSpriteNode?
    var sadAfter: SKSpriteNode?
    var cryAfter: SKSpriteNode?
    var cryBefore: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
    
    var score: Int = 0
    
    var canSpawnWater: Bool = true // Variabel untuk menandai apakah air masih boleh di-spawn
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.sadAfter?.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
            
            print(score)
            
            // Cek apakah sudah mencapai skor 10
            if score == 10 {
                canSpawnWater = false // Setel variabel untuk tidak lagi bisa spawn air
                cryAfter?.isHidden = false
                print("score sudah 10")
                
                // Menghentikan semua aksi yang diulang, termasuk spawnWater()
                self.removeAllActions()
            }
        }
    }
}
