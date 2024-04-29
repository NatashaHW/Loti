
import SpriteKit

class Scene3_Diskusi: SKScene {
    
    var bgDiskusi: SKSpriteNode?
    var lotiBNW: SKSpriteNode?
    var lotiSemiGreen: SKSpriteNode?
    var lotiGreen: SKSpriteNode?
    var litaBNW: SKSpriteNode?
    var litaSemiYellow: SKSpriteNode?
    var litaYellow: SKSpriteNode?
    
    var scene3IdeLoti1: SKSpriteNode?
    var scene3IdeLoti2: SKSpriteNode?
    var scene3IdeLoti3: SKSpriteNode?
    var lotiChat1: SKSpriteNode?
    var lotiChat2: SKSpriteNode?
    var lotiChat3: SKSpriteNode?
    var litaChat1: SKSpriteNode?
    
    var busBSD: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
    
    // Property untuk mendeteksi apakah node sedang di-drag
        var isDraggingScene3IdeLoti1 = false
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Inisialisasi cameraNode
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode!)
        
        // Mengambil node dari scene
        bgDiskusi = childNode(withName: "//bgDiskusi") as? SKSpriteNode
        lotiBNW = childNode(withName: "//lotiBNW") as? SKSpriteNode
        lotiSemiGreen = childNode(withName: "//lotiSemiGreen") as? SKSpriteNode
        lotiGreen = childNode(withName: "//lotiGreen") as? SKSpriteNode
        litaBNW = childNode(withName: "//litaBNW") as? SKSpriteNode
        litaSemiYellow = childNode(withName: "//litaSemiYellow") as? SKSpriteNode
        litaYellow = childNode(withName: "//litaYellow") as? SKSpriteNode
        
        scene3IdeLoti1 = childNode(withName: "//scene3IdeLoti1") as? SKSpriteNode
        scene3IdeLoti2 = childNode(withName: "//scene3IdeLoti2") as? SKSpriteNode
        scene3IdeLoti3 = childNode(withName: "//scene3IdeLoti3") as? SKSpriteNode
        
        lotiChat1 = childNode(withName: "//lotiChat1") as? SKSpriteNode
        lotiChat2 = childNode(withName: "//lotiChat2") as? SKSpriteNode
        lotiChat3 = childNode(withName: "//lotiChat3") as? SKSpriteNode
        litaChat1 = childNode(withName: "//litaChat1") as? SKSpriteNode
        
        busBSD = childNode(withName: "//busBSD") as? SKSpriteNode
        
        // Sembunyikan node yang tidak terlihat pada awalnya
        lotiBNW?.isHidden = false
        lotiSemiGreen?.isHidden = true
        lotiGreen?.isHidden = true
        
        litaBNW?.isHidden = false
        litaSemiYellow?.isHidden = true
        litaYellow?.isHidden = true
        
        scene3IdeLoti1?.isHidden = false
        scene3IdeLoti2?.isHidden = true
        scene3IdeLoti3?.isHidden = true
        
        lotiChat1?.isHidden = false
        lotiChat2?.isHidden = true
        lotiChat3?.isHidden = true
        litaChat1?.isHidden = false
        busBSD?.isHidden = false
        
        
        let slideTo = CGPoint(x: 2856.91, y: 61.112)
        let slideRightAction = SKAction.move(to: slideTo, duration: 2.5)
        slideRightAction.timingMode = .easeIn
        
        busBSD?.run(slideRightAction)
        
        // Tambahkan gesture recognizer ke scene3IdeLoti1
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        scene3IdeLoti1.view?.addGestureRecognizer(panGestureRecognizer)
        
        
        // Di dalam didMove(to:)
        if let sceneIdea = scene3IdeLoti1?.scene {
            // Tambahkan gesture recognizer ke properti view dari scene tersebut
            let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handlePan))
            scene3IdeLoti1?.inputView?.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    // Fungsi untuk menangani gesture pan
        @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
            
            
            guard let scene3IdeLoti1 = scene3IdeLoti1 else { return }
            
            // Ambil lokasi gerakan pan di scene
            let translation = recognizer.translation(in: self.view)
            
            switch recognizer.state {
            case .began, .changed:
                // Tentukan posisi baru untuk scene3IdeLoti1 berdasarkan pergeseran
                let newPosition = CGPoint(x: scene3IdeLoti1.position.x + translation.x, y: scene3IdeLoti1.position.y + translation.y)
                
                // Update posisi scene3IdeLoti1
                scene3IdeLoti1.position = newPosition
                
                // Atur ulang translation recognizer
                recognizer.setTranslation(CGPoint.zero, in: self.view)
                
                // Set isDraggingScene3IdeLoti1 ke true
                isDraggingScene3IdeLoti1 = true
                
            case .ended, .cancelled:
                // Set isDraggingScene3IdeLoti1 ke false
                isDraggingScene3IdeLoti1 = false
                
                // Reset posisi scene3IdeLoti1 ke posisi awal
                scene3IdeLoti1.position = CGPoint(x: 0, y: 0)
                
                // Unhide scene3IdeLoti2 dan lakukan animasi slide
                scene3IdeLoti2?.isHidden = false
                slideScene3IdeLoti2()
                
            default:
                break
            }
        }
        
        // Fungsi untuk melakukan animasi slide pada scene3IdeLoti2
        func slideScene3IdeLoti2() {
            // Tentukan posisi slideTo untuk scene3IdeLoti2
            let slideTo = CGPoint(x: 100, y: 0)
            
            // Buat action untuk animasi slide
            let slideAction = SKAction.move(to: slideTo, duration: 0.5)
            slideAction.timingMode = .easeIn
            
            // Jalankan action pada scene3IdeLoti2
            scene3IdeLoti2?.run(slideAction)
        }
        
    
    
}
