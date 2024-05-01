import SpriteKit
import AVFoundation

class ReplayScreen: SKScene {
    
    var BgReplay: SKSpriteNode?
    var Replay: SKSpriteNode?
    var Polaroid:SKSpriteNode?
    var audioPlayer: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        
        // Mengambil node dari scene
        BgReplay = childNode(withName: "//BgReplay") as? SKSpriteNode
        Replay = childNode(withName: "//Replay") as? SKSpriteNode
        Polaroid = childNode(withName: "//Polaroid") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mendapatkan lokasi sentuhan
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Cek apakah sentuhan terjadi di button
        if let button = Replay, button.contains(touchLocation) {
            // Panggil fungsi untuk menerapkan efek bouncy pada button
            applyBouncyEffect(to: button)
            
            // Panggil fungsi untuk memainkan suara bubble pop
            playBubblePopSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Panggil Scene2_Halte
                if let PlayScreen = PlayScreen (fileNamed: "PlayScreen") {
                    // Setup scene yang baru
                    PlayScreen.scaleMode = .aspectFill
                    // Transisi ke scene baru
                    self.view?.presentScene(PlayScreen, transition: SKTransition.crossFade(withDuration: 0.5))
                }
            }
        }
    }

    func applyBouncyEffect(to node: SKSpriteNode) {
        // Definisikan efek animasi bouncy
        let scaleUpAction = SKAction.scale(to: 1.2, duration: 0.1)
        let scaleDownAction = SKAction.scale(to: 1.0, duration: 0.1)
        let bounceAction = SKAction.sequence([scaleUpAction, scaleDownAction])
        
        // Terapkan efek bouncy pada button
        node.run(bounceAction)
    }
    
    func playBubblePopSound() {
        // Membuat path file suara
        if let soundURL = Bundle.main.url(forResource: "bubble_pop_sound", withExtension: "mp3") {
            do {
                // Inisialisasi audio player dengan suara dari path yang dibuat
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                // Mainkan suara
                audioPlayer?.play()
                print("audio keplay")
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}
