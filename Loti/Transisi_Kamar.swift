//
//  Tes transisi.swift
//  cadoptio
//
//  Created by Quinela Wensky on 26/04/24.
//

import SwiftUI
import SpriteKit
import GameplayKit

struct Gambar {
    var awal: String = "sceneBnW"
    var akhir: String = "sceneBiru"
}


struct Transisi_Kamar: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var currentImage: Gambar = Gambar()
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                // Gambar currentImage.awal berada di bagian atas
                Image(currentImage.awal)
                    .ignoresSafeArea()
                
                // Gambar currentImage.akhir
                ZStack {
                    Image(currentImage.akhir)
                        .ignoresSafeArea()
                        .mask({
                            Circle()
                                .frame(width: self.animate ? 1200 : 10, height: self.animate ? 1200 : 10)
                                .position(CGPoint(x: 90.0, y: 350.0))
                                .blur(radius: 20)
                        })
                        .opacity(animate ? 1 : 0)
                    
                    // Tombol Hp
                    Image("Hp")
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 1)) {
                                animate.toggle()
                            }
                        }
                        .position(CGPoint(x: 90.0, y: 350.0))
                }
                .ignoresSafeArea()
            }
            
            
            //             Tampilkan SKViewRepresentable() ketika animasi selesai
            if animate {
                SKViewRepresentable()
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}



// Definisikan SKViewRepresentable untuk menampilkan Scene1_Loti
struct SKViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        if let scene = Scene1_Loti(fileNamed: "Scene1_Loti") {
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
    Transisi_Kamar()
}
