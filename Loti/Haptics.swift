import CoreHaptics

class HapticUtils {
    static var engine: CHHapticEngine?
    static var hapticQueue = DispatchQueue(label: "HapticQueue")
    static var player: CHHapticAdvancedPatternPlayer? // Make player a static variable
    static var shouldContinueHaptic = true
    
    static func runHaptic(duration: TimeInterval) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            //            print("Device does not support haptics")
            return
        }
        
        do {
            // Create haptic engine
            engine = try CHHapticEngine()
            try engine?.start()
            
            // Define intensity and sharpness parameters
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            
            // Create haptic event with the specified duration
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: duration)
            
            // Create haptic pattern with the event
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            
            // Create player for the haptic pattern
            player = try engine?.makeAdvancedPlayer(with: pattern)
            
            // Start playing the haptic pattern
            try player?.start(atTime: CHHapticTimeImmediate)
            
            // Update haptic state
        } catch {
            print("Error creating haptic engine: \(error)")
        }
    }

    static func hapticHug() {
        let shorterDuration: TimeInterval = 0.2 // Adjust the duration as needed
        runHaptic(duration: shorterDuration)
    }
    
    static func hapticIde() {
        let shorterDuration: TimeInterval = 0.5 // Adjust the duration as needed
        runHaptic(duration: shorterDuration)
    }
    
    static func runHapticOnBackgroundThreadWithinInterval(seconds: TimeInterval) {
        hapticQueue.async {
            // Repeat haptic feedback at the specified time interval until shouldContinueHaptic is false
            while shouldContinueHaptic {
                runHaptic(duration: 1)
                Thread.sleep(forTimeInterval: seconds)
            }
        }
    }
    
    static func stopHaptic() {
        shouldContinueHaptic = false
        // Additionally, you may want to call stopHaptic() to stop any ongoing haptic feedback
        // This will ensure that if the haptic feedback is currently playing, it will be stopped immediately
//        stopHaptic()
    }
}
