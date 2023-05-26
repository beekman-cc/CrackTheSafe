//
//  GameView.swift
//  CrackTheSafe
//
//  Created by Robin Beekman on 26/05/2023.
//

import Foundation
import SwiftUI
import UIKit

struct GameView: View {
    @GestureState private var dragOffset: CGSize = .zero
    @State var rotation: Angle = .zero
    @State private var number: Int = 0 // New variable to track the rotation count
    var rotateValue = 0
    var idk = 0
    
    let sensitivity: Double = 1
    let rotationThreshold: Double = 45.0
    
    @State private var previousDegrees: Int = 0
    
    @State private var progressValue: Float = 0.5
    
    var body: some View {

        GeometryReader { geometry in
            Image("onetoseven")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 400)
                .foregroundColor(Color("White"))
                .rotationEffect(rotation)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            updateRotation(with: value.location)
                        }
                        .onEnded { value in
                            updateRotation(with: value.location)
                        }
                )
                .onChange(of: rotation) { value in
                    let currentDegrees = Int(rotation.degrees.rounded())

                    // Check if a new multiple of 8 degrees has been crossed
                    if currentDegrees % 45 == 0 && currentDegrees != previousDegrees {
                        print(currentDegrees)
                        incrementNumber()
                        generateHapticFeedback()
                        previousDegrees = currentDegrees
                        print(currentDegrees % 8)
                    }
                }
        }
        Rectangle()
                .frame(width: 1, height: 20)
                .foregroundColor(.white)
            
        
        
        Spacer()
        
//        VStack {
//            Slider(value: $progressValue, in: 0...10, step: 1)
//                .onChange(of: progressValue) { _ in
//                    generateHapticFeedback()
//                }
//        }
    }
    

    func updateRotation(with touchPoint: CGPoint) {
        let circleCenter = CGPoint(x: 200, y: 200)
        let angle = calculateAngle(from: touchPoint, to: circleCenter) * sensitivity
        rotation = angle
    }

    func calculateAngle(from startPoint: CGPoint, to endPoint: CGPoint) -> Angle {
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        var angle = atan2(dy, dx)
        
        if angle < 0 {
            angle += .pi * 2
        }
        
        return Angle(radians: Double(angle))
    }
    
    func incrementNumber() {
        number += 1
    }

    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
}
