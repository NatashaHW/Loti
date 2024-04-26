import SpriteKit
import GameplayKit

class Scene1_Loti: SKScene {
    
    var scene1SleepColor: SKSpriteNode?
    var scene1Yawn1: SKSpriteNode?
    var scene1Yawn2: SKSpriteNode?
    var cameraNode: SKCameraNode?
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mendapatkan referensi ke node
        scene1SleepColor = childNode(withName: "//scene1SleepColor") as? SKSpriteNode
        scene1Yawn1 = childNode(withName: "//scene1Yawn1") as? SKSpriteNode
        scene1Yawn2 = childNode(withName: "//scene1Yawn2") as? SKSpriteNode
        
        scene1Yawn2?.isHidden = true
        
        // Menjalankan aksi delay 2 detik sebelum menggerakkan kamera ke bawah
        let waitBeforeMovingCamera = SKAction.wait(forDuration: 2.0)
        
        // Menggerakkan kamera ke bawah ke scene1Yawn1 setelah delay
        let moveCamera = SKAction.run {
            self.cameraNode?.run(SKAction.move(to: CGPoint(x: self.scene1Yawn1!.position.x, y: self.scene1Yawn1!.position.y), duration: 1.0))
        }
        
        // Menjalankan aksi delay 0.3 detik sebelum menampilkan scene1Yawn2
        let waitBeforeShowingScene1Yawn2 = SKAction.wait(forDuration: 0.8)
        
//        // Menyembunyikan scene1Yawn2 setelah delay
//        let hideScene1Yawn2 = SKAction.run {
//            self.scene1Yawn2?.isHidden = true
//        }
        
        // Menampilkan scene1Yawn2 setelah delay
        let showScene1Yawn2 = SKAction.run {
            self.scene1Yawn2?.isHidden = false
        }
        
        // Menjalankan aksi secara berurutan
        self.run(SKAction.sequence([waitBeforeMovingCamera, moveCamera, waitBeforeShowingScene1Yawn2, waitBeforeShowingScene1Yawn2, showScene1Yawn2]))
    }
}
