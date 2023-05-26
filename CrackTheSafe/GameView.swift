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

    var body: some View {
        GeometryReader { geometry in
            Image("onetoseven")
                .resizable()
                .frame(maxWidth: 200, maxHeight: 200)
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
                .onAppear {
                    print("Image size: \(geometry.size)")
                }
                .onChange(of: rotation, perform: { value in
                    let degrees = rotation.degrees
                    if degrees == 360 {
                        incrementNumber()
                        generateHapticFeedback()
                    }
//                    if degrees.truncatingRemainder(dividingBy: 45) == 0 {
//                        incrementNumber()
//                        print(number)
//                        generateHapticFeedback()
//                    }
                })
            Text("\(idk)")
        }
    }
    


    func updateRotation(with touchPoint: CGPoint) {
        let circleCenter = CGPoint(x: 100, y: 100)
        let angle = calculateAngle(from: touchPoint, to: circleCenter)
        rotation = angle
    }

    func calculateAngle(from startPoint: CGPoint, to endPoint: CGPoint) -> Angle {
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let angle = atan2(dy, dx)
        return Angle(radians: Double(angle))
    }

    func incrementNumber() {
        number += 1
        if number == 8 {
            number = 0
        }
    }

    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}
    
    
    
    
    
    
