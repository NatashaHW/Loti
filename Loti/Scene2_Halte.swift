
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
    
    var bubbleRed1Tap: SKSpriteNode?
    var bubbleRed2Tap: SKSpriteNode?
    var bubbleRed3Tap: SKSpriteNode?
    var bubbleRed4Tap: SKSpriteNode?
    
    
    var isScene2ClockHandRotating = false
    var cameraNode: SKCameraNode?
    
    var tapCount = 0
    var swipeCount = 0
    
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
        scene2Instruction = childNode(withName: "//scene2Instruction") as? SKSpriteNode
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
        
        
        // Sembunyikan node yang tidak terlihat pada awalnya
        scene2BNW2?.isHidden = true
        scene2Color1?.isHidden = true
        scene2Color2?.isHidden = true
        scene2Instruction?.isHidden = true
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
        
        // Mulai animasi setelah beberapa detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.scene2BNW2?.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            // Unhide dengan transition slide dari kanan ke kiri
            let slideDistance = self.size.width // Jarak pergeseran
            let slideLeftAction = SKAction.moveBy(x: -slideDistance, y: 0, duration: 0.5) // Menggeser ke kiri sejauh slideDistance dalam 0.5 detik
            self.scene2Instruction?.run(slideLeftAction)
            self.scene2ClockHand?.run(slideLeftAction)
            self.scene2Clock?.run(slideLeftAction)
            self.scene2BgClock?.run(slideLeftAction)
            self.scene2Hand?.run(slideLeftAction)
            
            self.scene2Instruction?.isHidden = false
            self.scene2ClockHand?.isHidden = false
            self.scene2Clock?.isHidden = false
            self.scene2BgClock?.isHidden = false
            self.scene2Hand?.isHidden = false
        }
        
        // Di dalam didMove(to:)
        if let sceneContainingBubbleRed1 = bubbleRed1?.scene {
            // Tambahkan gesture recognizer ke properti view dari scene tersebut
            let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
            gestureRecognizer.direction = .up
            gestureRecognizer.numberOfTouchesRequired = 1
            sceneContainingBubbleRed1.view?.addGestureRecognizer(gestureRecognizer)
        }

    }
    
    
    @objc func swipeGesture (_ recognizer: UISwipeGestureRecognizer) {
            // Handle swipe gesture here
            print("swipe")
            
            swipeCount += 1
        
        switch swipeCount {
        case 1:
            // Tentukan posisi baru untuk bubbleRed1 setelah pergeseran
            let newPosition = CGPoint(x: -12, y: -1959.5)
            
            // Buat action untuk pergeseran ke atas
            let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
            
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
            }
        case 2:
            // Jika ini adalah swipe kedua
            // Tentukan posisi baru untuk bubbleRed2 setelah pergeseran kedua
            let newPosition = CGPoint(x: 222.537, y: -2301.2)
            
            // Buat action untuk pergeseran ke atas
            let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
            
            // Jalankan action pada bubbleRed2
            bubbleRed2?.run(slideUpAction)
            
            // Tunggu 0.2 detik lebih lama
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // Tampilkan bubbleRed2 setelah menunggu
                self.bubbleRed3?.isHidden = false
            }
        
        case 3:
            // Jika ini adalah swipe ketiga
            // Tentukan posisi baru untuk bubbleRed3 setelah pergeseran ketiga
            let newPosition = CGPoint(x: 193.187, y: -1832.604)
            
            // Buat action untuk pergeseran ke atas
            let slideUpAction = SKAction.move(to: newPosition, duration: 0.5)
            
            // Jalankan action pada bubbleRed3
            bubbleRed3?.run(slideUpAction)
            
            // Tunggu 0.2 detik lebih lama
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // Tampilkan bubbleRed3 setelah menunggu
                self.bubbleRed3?.isHidden = false
            }
        default:
            break
        }
                
    }


    
    // Fungsi untuk menangani sentuhan di layar
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Mendapatkan lokasi sentuhan saat ini
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        // Cek apakah sentuhan terjadi di area scene2Clock atau scene2ClockHand
        if let clock = scene2Clock, clock.contains(touchLocation) {
            // Memulai rotasi scene2ClockHand searah jarum jam
            rotateClockHandClockwise()
            tapCount += 1
        } else if let clockHand = scene2ClockHand, clockHand.contains(touchLocation) {
            // Memulai rotasi scene2ClockHand searah jarum jam
            rotateClockHandClockwise()
            tapCount += 1
        }
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
                    self.bubbleRed2?.position = CGPoint(x: 2, y: -3540)
                    self.bubbleRed3?.position = CGPoint(x: 8.65, y: -3540)
                    
//                    // Animasi saat bergeser ke atas
//                    let slideUpAction = SKAction.move(to: CGPoint(x: -12, y: -1959.5), duration: 0.5)
//                    self.bubbleRed1?.run(slideUpAction)
//                    
//                    // Menampilkan bubbleRed1 dan mengubah posisinya
//                    self.bubbleRed2?.isHidden = false
//                    self.bubbleRed2?.position = CGPoint(x: 2, y: -3540)
//                        
//                    // Animasi saat bergeser ke atas
//                    let slideUpAction2 = SKAction.move(to: CGPoint(x: 222.537, y: -2301.2), duration: 0.5)
//                    self.bubbleRed2?.run(slideUpAction2)
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
