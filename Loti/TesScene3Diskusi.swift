//
//  TesScene3Diskusi.swift
//  Loti
//
//  Created by Quinela Wensky on 29/04/24.
//

import SwiftUI
import SpriteKit

struct TesScene3Diskusi: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        SKViewRepresentable()
            .frame(width: screenWidth, height: screenHeight, alignment: .center)
            .edgesIgnoringSafeArea(.all)
    }
}

struct SKViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        if let scene = SKScene(fileNamed: "Scene3_Diskusi") {
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .clear
            skView.presentScene(scene)
        }
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        // Tidak ada pembaruan yang diperlukan
    }
}

#Preview {
    TesScene3Diskusi()
}
