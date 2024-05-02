import SpriteKit
import AVFoundation

class PlayScreen: SKScene {
    
    var BgHomePlay: SKSpriteNode?
    var PlayButton: SKSpriteNode?
    var popBubble: SKAudioNode!
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        
        // Mengambil node dari scene
        BgHomePlay = childNode(withName: "//BgHomePlay") as? SKSpriteNode
        PlayButton = childNode(withName: "//PlayButton") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mendapatkan lokasi sentuhan
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Cek apakah sentuhan terjadi di button
        if let button = PlayButton, button.contains(touchLocation) {
            // Panggil fungsi untuk menerapkan efek bouncy pada button
            applyBouncyEffect(to: button)
            
            // Panggil fungsi untuk memainkan suara bubble pop
            popBubble = playBackgroundMusic(musicName: "Pop Edit")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Panggil Scene2_Halte
                if let scene1 = Scene1_Loti(fileNamed: "Scene1_Loti") {
                    // Setup scene yang baru
                    scene1.scaleMode = .aspectFill
                    // Transisi ke scene baru
                    self.view?.presentScene(scene1, transition: SKTransition.crossFade(withDuration: 0.5))
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
    
}
