
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

    var cameraNode: SKCameraNode?
    
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
        
        
    }
    
    
    // Fungsi untuk menangani sentuhan di layar
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    
    

    
    func rotateClockHandClockwise() {
        
    }
    
}
