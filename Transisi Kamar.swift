//
//  Tes transisi.swift
//  cadoptio
//
//  Created by Quinela Wensky on 26/04/24.
//

import SwiftUI

struct Gambar {
    var awal: String = "sceneBnW"
    var akhir: String = "sceneBiru"

}
    
struct Transisi_Kamar: View {
    var currentImage: Gambar = Gambar()
    @State var animate: Bool = false
    
    var body: some View {
        ZStack{
            Image(currentImage.awal)
            Image(currentImage.akhir)
                .mask({
                    Circle()
                        .frame(width: self.animate ? 1200 : 10, height: self.animate ? 1200 : 10)
                        .position(CGPoint(x: 90.0, y: 350.0))
                        .blur(radius: 20)
                })
                .opacity(animate ? 1 : 0)
            
//            Circle()
//                .frame(width: self.animate ? 1200 : 10, height: self.animate ? 1200 : 10)
//                .position(CGPoint(x: 90.0, y: 350.0))
//                .blur(radius: 10)
            
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
}

#Preview {
    Transisi_Kamar()
}
