import SpriteKit

class Scene4_Envy: SKScene {
    
    var scene4_envy1: SKSpriteNode?
    var scene4_envy2: SKSpriteNode?
    var background_before: SKSpriteNode?
    var background_after: SKSpriteNode?
    var Lita: SKSpriteNode?
    var Loti: SKSpriteNode?
    var slider: SKSpriteNode?
    var button: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
    
    // Variabel untuk menyimpan posisi awal sentuhan pada button
    var initialTouchPosition: CGPoint?
    
    // Batasan geseran button di sisi kanan dan kiri layar
    let maxLeftPosition: CGFloat = 20
    let maxRightPosition: CGFloat = UIScreen.main.bounds.width - 20 // Menggunakan lebar layar
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mengambil node dari scene
        scene4_envy1 = childNode(withName: "//scene4_envy1") as? SKSpriteNode
        scene4_envy2 = childNode(withName: "//scene4_envy2") as? SKSpriteNode
        background_before = childNode(withName: "//background_before") as? SKSpriteNode
        background_after = childNode(withName: "//background_after") as? SKSpriteNode
        Lita = childNode(withName: "//Lita") as? SKSpriteNode
        Loti = childNode(withName: "//Loti") as? SKSpriteNode
        slider = childNode(withName: "//slider") as? SKSpriteNode
        button = childNode(withName: "//button") as? SKSpriteNode
        
        // Sembunyikan scene4_envy2 dan tunjukkan scene4_envy1
        scene4_envy1?.isHidden = false
        scene4_envy2?.isHidden = true
        background_after?.isHidden = true
        
        // Setelah 1 detik, tunjukkan scene4_envy2
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.scene4_envy2?.isHidden = false
        }
        
        // Setelah 0.8 detik lagi, scroll ke background_before
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let backgroundBefore = self.background_before {
                let moveAction = SKAction.move(to: backgroundBefore.position, duration: 1.5)
                self.cameraNode?.run(moveAction)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mendapatkan lokasi sentuhan
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Cek apakah sentuhan terjadi di button
        if let button = button, button.contains(touchLocation) {
            // Simpan posisi awal sentuhan
            initialTouchPosition = touchLocation
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mendapatkan lokasi sentuhan
        guard let touch = touches.first, let button = button, let initialTouchPosition = initialTouchPosition else { return }
        let touchLocation = touch.location(in: self)
        
        // Hitung pergeseran sentuhan
        let deltaX = touchLocation.x - initialTouchPosition.x
        
        // Jika pergeseran sentuhan adalah ke arah kanan, lakukan pergeseran pada button
        if deltaX > 0 {
            // Hitung posisi baru button
            var newPositionX = button.position.x + deltaX
            
            // Batasi posisi button agar tidak melewati batas kanan layar
            newPositionX = min(newPositionX, maxRightPosition)
            
            // Tetapkan posisi baru button
            button.position.x = newPositionX
            
            // Geser Lita ke kiri secara otomatis
            Lita?.position.x -= (deltaX / 2 + 1)
            
            // Geser Loti ke kanan secara otomatis
            Loti?.position.x += (deltaX / 2 + 5)
            
        }
        
        // Update posisi awal sentuhan
        self.initialTouchPosition = touchLocation
    }




    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset posisi awal sentuhan
        initialTouchPosition = nil
    }
}
