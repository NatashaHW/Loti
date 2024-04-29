import SpriteKit
import GameplayKit


class Scene1_Loti: SKScene {
    
    var scene1SleepColor: SKSpriteNode?
    var scene1Yawn1: SKSpriteNode?
    var scene1Yawn2: SKSpriteNode?
    
    var scene1ChatBNW: SKSpriteNode?
    var scene1ChatOrange: SKSpriteNode?
    var scene1ChatYellow: SKSpriteNode?
    var scene1ChatBlue: SKSpriteNode?
    
    var emotionOrange: SKSpriteNode?
    var emotionYellow: SKSpriteNode?
    var emotionBlue: SKSpriteNode?
    
    var bubbleOrange1: SKSpriteNode?
    var bubbleYellow1: SKSpriteNode?
    var bubbleBlue1: SKSpriteNode?
    
    var friendsBubble0: SKSpriteNode?
    var friendsBubble1: SKSpriteNode?
    
    var bubbleOrange2: SKSpriteNode?
    var bubbleYellow2: SKSpriteNode?
    var bubbleBlue2: SKSpriteNode?
    
    var cameraNode: SKCameraNode?
    
    var tapCountOrange = 0
    var tapCountYellow = 0
    var tapCountBlue = 0
    
    var emotionSelected = false
    
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
        
        scene1ChatBNW = childNode(withName: "//scene1ChatBNW") as? SKSpriteNode
        scene1ChatOrange = childNode(withName: "//scene1ChatOrange") as? SKSpriteNode
        scene1ChatYellow = childNode(withName: "//scene1ChatYellow") as? SKSpriteNode
        scene1ChatBlue = childNode(withName: "//scene1ChatBlue") as? SKSpriteNode
        
        emotionOrange = childNode(withName: "//emotionOrange") as? SKSpriteNode
        emotionYellow = childNode(withName: "//emotionYellow") as? SKSpriteNode
        emotionBlue = childNode(withName: "//emotionBlue") as? SKSpriteNode
        
        bubbleOrange1 = childNode(withName: "//bubbleOrange1") as? SKSpriteNode
        bubbleYellow1 = childNode(withName: "//bubbleYellow1") as? SKSpriteNode
        bubbleBlue1 = childNode(withName: "//bubbleBlue1") as? SKSpriteNode
        
        friendsBubble0 = childNode(withName: "//friendsBubble0") as? SKSpriteNode
        friendsBubble1 = childNode(withName: "//friendsBubble1") as? SKSpriteNode
        
        bubbleOrange2 = childNode(withName: "//bubbleOrange2") as? SKSpriteNode
        bubbleYellow2 = childNode(withName: "//bubbleYellow2") as? SKSpriteNode
        bubbleBlue2 = childNode(withName: "//bubbleBlue2") as? SKSpriteNode
        
        // Set initial state
        scene1Yawn2?.isHidden = true
        scene1ChatOrange?.isHidden = true
        scene1ChatYellow?.isHidden = true
        scene1ChatBlue?.isHidden = true
        
        bubbleOrange1?.isHidden = true
        bubbleYellow1?.isHidden = true
        bubbleBlue1?.isHidden = true
        
        friendsBubble0?.isHidden = true
        friendsBubble1?.isHidden = true
        
        bubbleOrange2?.isHidden = true
        bubbleYellow2?.isHidden = true
        bubbleBlue2?.isHidden = true
        
        // Menjalankan aksi delay 2 detik sebelum menggerakkan kamera ke bawah
        let waitBeforeMovingCamera = SKAction.wait(forDuration: 2.0)
        
        // Menggerakkan kamera ke bawah ke scene1Yawn1 setelah delay
        let moveCamera1 = SKAction.run {
            self.cameraNode?.run(SKAction.move(to: CGPoint(x: self.scene1Yawn1!.position.x, y: self.scene1Yawn1!.position.y), duration: 1.0))
        }
        
        // Menjalankan aksi delay 0.3 detik sebelum menampilkan scene1Yawn2
        let waitBeforeShowingScene1Yawn2 = SKAction.wait(forDuration: 0.8)
        
        // Menampilkan scene1Yawn2 setelah delay
        let showScene1Yawn2 = SKAction.run {
            self.scene1Yawn2?.isHidden = false
        }
        
        // Menggerakkan kamera ke bawah ke scene1Yawn1 setelah delay
        let moveCamera2 = SKAction.run {
            self.cameraNode?.run(SKAction.move(to: CGPoint(x: self.scene1ChatBNW!.position.x, y: self.scene1ChatBNW!.position.y), duration: 1.0))
        }
        
        
        
        // Menjalankan aksi secara berurutan
        self.run(SKAction.sequence([
            waitBeforeMovingCamera,
            moveCamera1,
            waitBeforeShowingScene1Yawn2,
            waitBeforeShowingScene1Yawn2,
            showScene1Yawn2,
            waitBeforeMovingCamera,
            moveCamera2
        ]))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Memeriksa apakah emosi sudah dipilih sebelumnya
        guard !emotionSelected else { return }
        
        // Mengambil sentuhan pertama
        guard let touch = touches.first else { return }
        
        // Mendapatkan lokasi sentuhan
        let touchLocation = touch.location(in: self)
        
        
        // Memeriksa apakah emosi oranye dipilih
        if emotionOrange?.contains(touchLocation) ?? false {
            // User memilih emosi oranye
            tapCountOrange += 1
            animateVibration(for: emotionOrange)
            showBubbleAndChat1(for: emotionOrange, chatNode: scene1ChatOrange, bubbleNode: bubbleOrange1)
            print("Orange Tapped \(tapCountOrange) times")
        }
        // Memeriksa apakah emosi kuning dipilih
        else if emotionYellow?.contains(touchLocation) ?? false {
            // User memilih emosi kuning
            tapCountYellow += 1
            animateVibration(for: emotionYellow)
            showBubbleAndChat1(for: emotionYellow, chatNode: scene1ChatYellow, bubbleNode: bubbleYellow1)
            print("Yellow Tapped \(tapCountYellow) times")
        }
        // Memeriksa apakah emosi biru dipilih
        else if emotionBlue?.contains(touchLocation) ?? false {
            // User memilih emosi biru
            tapCountBlue += 1
            animateVibration(for: emotionBlue)
            showBubbleAndChat1(for: emotionBlue, chatNode: scene1ChatBlue, bubbleNode: bubbleBlue1)
            print("Blue Tapped \(tapCountBlue) times")
        }
        
        // Setel bahwa emosi telah dipilih
        emotionSelected = true
        
        // Memanggil friendsBubble setelah 1 detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.friendsBubble()
            
            //tambahkan touches second nya yg diambil (utk chat 2)
            
            // Navigate to Scene2_Halte
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // Panggil Scene2_Halte
                if let scene2 = Scene2_Halte(fileNamed: "Scene2_Halte") {
                    // Setup scene yang baru
                    scene2.scaleMode = .aspectFill
                    // Transisi ke scene baru
                    self.view?.presentScene(scene2, transition: SKTransition.moveIn(with: .right, duration: 2.0))
                }
            }
        }
    }
    
    
    // Fungsi untuk menampilkan animasi getaran
    func animateVibration(for node: SKSpriteNode?) {
        guard let node = node else { return }
        let rotateRight = SKAction.rotate(byAngle: CGFloat.pi / 18, duration: 0.05)
        let rotateLeft = SKAction.rotate(byAngle: -CGFloat.pi / 18, duration: 0.05)
        let sequence = SKAction.sequence([rotateRight, rotateLeft])
        let repeatAction = SKAction.repeat(sequence, count: 4)
        node.run(repeatAction)
    }
    
    // Fungsi untuk menampilkan gelembung dan obrolan
    func showBubbleAndChat1(for emotion: SKSpriteNode?, chatNode: SKSpriteNode?, bubbleNode: SKSpriteNode?) {
        hideAllBubbleAndChat1()
        guard let emotion = emotion, let chatNode = chatNode, let bubbleNode = bubbleNode else { return }
        chatNode.isHidden = false
        bubbleNode.isHidden = false
        
        // Mengatur posisi gelembung
        bubbleNode.position.y -= 600
        
        // Animasi slide up untuk gelembung
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 600), duration: 0.3)
        bubbleNode.run(moveUp)
    }
    
    // Fungsi untuk menampilkan gelembung teman
    func friendsBubble() {
        hideAllFriendsBubble()
        
        // Mengatur indeks gelembung teman secara acak
        let friendsBubbleIndex = Int.random(in: 0...1)
        
        // Membuat dan menampilkan gelembung teman
        if friendsBubbleIndex == 0 {
            friendsBubble0?.isHidden = false
            scene1ChatYellow?.isHidden = false
            
            // Mengatur posisi gelembung
            friendsBubble0?.position.y -= 400
            
            // Animasi slide up untuk gelembung
            let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 400), duration: 0.3)
            friendsBubble0?.run(moveUp)
        } else {
            friendsBubble1?.isHidden = false
            scene1ChatBlue?.isHidden = false
            
            // Mengatur posisi gelembung
            friendsBubble1?.position.y -= 400
            
            // Animasi slide up untuk gelembung
            let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 400), duration: 0.3)
            friendsBubble1?.run(moveUp)
        }
    }
    
    // Fungsi untuk menyembunyikan semua gelembung teman
    func hideAllFriendsBubble() {
        friendsBubble0?.isHidden = true
        friendsBubble1?.isHidden = true
    }
    
    // Fungsi untuk menyembunyikan semua gelembung dan obrolan
    func hideAllBubbleAndChat1() {
        scene1ChatOrange?.isHidden = true
        bubbleOrange1?.isHidden = true
        scene1ChatYellow?.isHidden = true
        bubbleYellow1?.isHidden = true
        scene1ChatBlue?.isHidden = true
        bubbleBlue1?.isHidden = true
    }
    
    // Fungsi untuk menampilkan gelembung dan obrolan kedua
    func showBubbleAndChat2(for emotion: SKSpriteNode?, chatNode: SKSpriteNode?, bubbleNode: SKSpriteNode?) {
        hideAllBubbleAndChat2()
        guard let emotion = emotion, let chatNode = chatNode, let bubbleNode = bubbleNode else { return }
        chatNode.isHidden = false
        bubbleNode.isHidden = false
        
        // Mengatur posisi gelembung
        bubbleNode.position.y -= 200
        
        // Animasi slide up untuk gelembung
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 0.3)
        bubbleNode.run(moveUp)
    }
    
    // Fungsi untuk menyembunyikan semua gelembung dan obrolan kedua
    func hideAllBubbleAndChat2() {
        bubbleOrange2?.isHidden = true
        bubbleYellow2?.isHidden = true
        bubbleBlue2?.isHidden = true
    }
}

