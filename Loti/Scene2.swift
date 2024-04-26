import SpriteKit

class Scene2: SKScene {
    
    var scene2BNW1: SKSpriteNode?
    var scene2BNW2: SKSpriteNode?
    var scene2Color1: SKSpriteNode?
    var scene2Color2: SKSpriteNode?
    var scene2Instruction: SKSpriteNode?
    var scene2ClockHand: SKSpriteNode?
    var scene2Clock: SKSpriteNode?
    var scene2BgClock: SKSpriteNode?
    var scene2Hand: SKSpriteNode?
    
    var isScene2ClockHandRotating = false
    
    override func didMove(to view: SKView) {
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
        
        // Sembunyikan node yang tidak terlihat pada awalnya
        scene2BNW2?.isHidden = true
        scene2Color1?.isHidden = true
        scene2Color2?.isHidden = true
        scene2Instruction?.isHidden = true
        scene2ClockHand?.isHidden = true
        scene2Clock?.isHidden = true
        scene2BgClock?.isHidden = true
        scene2Hand?.isHidden = true
        
        // Mulai animasi setelah beberapa detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.scene2BNW2?.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
        } else if let clockHand = scene2ClockHand, clockHand.contains(touchLocation) {
            // Memulai rotasi scene2ClockHand searah jarum jam
            rotateClockHandClockwise()
        }
    }
    
    func rotateClockHandClockwise() {
        // Memeriksa apakah sudah ada rotasi yang sedang berlangsung
        guard !isScene2ClockHandRotating else { return }
        
        // Memulai animasi rotasi
        let rotateAction = SKAction.rotate(byAngle: -CGFloat.pi / 6, duration: 0.2) // Rotasi sebesar 30 derajat (π/6 radian) dalam 0.2 detik
        let rotateSequence = SKAction.sequence([rotateAction, SKAction.run {
            // Memeriksa apakah scene2ClockHand sudah berputar sebanyak 200 derajat
            if let rotation = self.scene2ClockHand?.zRotation{
                if rotation == -2.0943949076860062 {
                    self.scene2Color1?.isHidden = false
                } else if rotation == -5.7595921609132406 {
                    self.scene2Color2?.isHidden = false
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
        
        // Mendapatkan sudut rotasi sebelum dan sesudah rotasi
        let initialRotation = scene2ClockHand?.zRotation ?? 0
        let finalRotation = initialRotation - CGFloat.pi / 6
        
        // Print sudut rotasi saat ini
        print("Sudut rotasi sekarang: \(finalRotation)")
        print("Initial rotation: \(initialRotation)")
    }

}
