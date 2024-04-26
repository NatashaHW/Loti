//
//  Scene1.swift
//  Loti
//
//  Created by Natasha Hartanti Winata on 25/04/24.
//

import SpriteKit
import GameplayKit

class Scene1: SKScene {
    
    var phoneAlarm: SKSpriteNode?
    var vibrating = false
    
    var scene1SleepBNW: SKSpriteNode?
    var scene1SleepColor: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // Mengatur latar belakang menjadi warna putih
        backgroundColor = SKColor.white
        
        // Mengambil node asset alarm dari scene
        phoneAlarm = childNode(withName: "//scene1PhoneAlarm") as? SKSpriteNode
        
        // Mengambil node untuk sleep BNW dan sleep color
        scene1SleepBNW = childNode(withName: "//scene1SleepBNW") as? SKSpriteNode
        scene1SleepColor = childNode(withName: "//scene1SleepColor") as? SKSpriteNode
        
        // Sembunyikan scene1SleepColor pada awalnya
        scene1SleepColor?.isHidden = true
        
        // Memulai animasi getar saat scene dimuat
        vibrateAlarm()
    }
    
    func vibrateAlarm() {
        if let alarm = phoneAlarm {
            let delay = SKAction.wait(forDuration: 0.5)
            let startVibrationAction = SKAction.run {
                self.startVibration()
            }
            alarm.run(SKAction.sequence([delay, startVibrationAction]))
        }
    }
    
    // Function untuk menjalankan animasi getar dan rotasi secara berulang
    func startVibration() {
        guard let alarm = phoneAlarm else { return }
        
        let rotateClockwise = SKAction.rotate(byAngle: CGFloat.pi/45.0, duration: 0.1)
        let rotateAntiClockwise = SKAction.rotate(byAngle: -CGFloat.pi/45.0, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.2)
        
        let sequence = SKAction.sequence([rotateClockwise, rotateAntiClockwise, rotateClockwise, rotateAntiClockwise, wait])
        let repeatAction = SKAction.repeatForever(sequence)
        
        // Menjalankan animasi pada asset alarm
        alarm.run(repeatAction)
        
        // Mengatur status vibrating menjadi true
        vibrating = true
    }
    
    // Function untuk menghentikan animasi vibrate
    func stopVibration() {
        guard let alarm = phoneAlarm,
              let sleepBNW = scene1SleepBNW,
              let sleepColor = scene1SleepColor else { return }
        
        // Menghentikan semua animasi yang berjalan pada asset alarm
        alarm.removeAllActions()
        
        // Mengatur status vibrating menjadi false
        vibrating = false
        
        // Munculkan scene1SleepColor dan sembunyikan scene1SleepBNW
        sleepColor.isHidden = false
        sleepBNW.isHidden = true
        
        // Buat sprite baru untuk efek masking
        let maskNode = SKSpriteNode(color: .white, size: CGSize(width: frame.width, height: frame.height))
        maskNode.zPosition = -1 // Pastikan berada di belakang semua node lain
        
        // Atur posisi masker sama dengan posisi alarm
        maskNode.position = alarm.position
        
        // Tambahkan efek blur ke masker
//        let blurFilter = CIFilter(name: "CIGaussianBlur")
//        blurFilter?.setValue(30, forKey: kCIInputRadiusKey)
//        maskNode.filter = blurFilter
        
        // Tambahkan masker ke scene
        // test
        addChild(maskNode)
        
//        sleepColor.mask = maskNode
    }

    
    // Function untuk menangani ketika asset alarm ditekan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            for touch in touches {
                let location = touch.location(in: self)
                if let node = self.nodes(at: location).first {
                    if node == phoneAlarm && vibrating {
                        stopVibration()
                    } else if node == phoneAlarm {
                        startVibration()
                    }
                }
            }
        }
    }
}
