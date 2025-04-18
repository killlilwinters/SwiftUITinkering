//
//  HapticProvider.swift
//  MLXTextSummarizer
//
//  Created by Maks Winters on 21.03.2025.
//
import UIKit
import CoreHaptics

enum HapticError: Error {
    case deviceUnsupported
    case engineUnavailable
}

struct HapticProvider {
    private let engine: CHHapticEngine?
    private let eventGenerator = UINotificationFeedbackGenerator()
    
    init?() throws(HapticError) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { throw .deviceUnsupported }
        
        guard let engine = try? CHHapticEngine() else { return nil }
        self.engine = engine
        
        do { try engine.start() } catch { throw .engineUnavailable }
    }
    
    func performSuccess() {
        eventGenerator.notificationOccurred(.success)
    }
    
    func performFailure() {
        eventGenerator.notificationOccurred(.error)
    }
    
    func performWarning() {
        eventGenerator.notificationOccurred(.warning)
    }
    
    func performLightTap() throws {
        
        let parameters = getParameters(intensity: 0.2, sharpness: 0.5)
        
        let events = getImmidiateEvent(parameters: parameters)
        
        try? performEvents(events: events)
        
    }
    
    func performMediumTap() throws {
        
        let parameters = getParameters(intensity: 0.7, sharpness: 0.7)
        
        let events = getImmidiateEvent(parameters: parameters)
        
        try? performEvents(events: events)
        
    }
    
    private func performEvents(events: [CHHapticEvent]) throws {
        guard let engine else { return }
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            throw error
        }
    }
    
    private func getImmidiateEvent(parameters: [CHHapticEventParameter]) -> [CHHapticEvent] {
        [CHHapticEvent(eventType: .hapticTransient, parameters: parameters, relativeTime: 0)]
    }
    
    private func getParameters(intensity: Float, sharpness: Float) -> [CHHapticEventParameter] {
        return [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        ]
    }
    
}
