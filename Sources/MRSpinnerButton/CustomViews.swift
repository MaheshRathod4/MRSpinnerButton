//
//  CustomViews.swift
//  
//
//  Created by Mahesh Rathod on 26/03/23.
//

import Foundation
import SwiftUI

struct Checkmark: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
 
        var path = Path()
        path.move(to: .init(x: 0 * width, y: 0.6 * height))
        path.addLine(to: .init(x: 0.3 * width, y: 1.0 * height))
        path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
        return path
    }
}

struct Cross: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
 
        var path = Path()
        path.move(to: .init(x: 0 * width, y: 0.9 * height))
        path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
        path.move(to: .init(x: 0, y: 0))
        path.addLine(to: .init(x: 1.0 * width, y: 0.9 * height))
        return path
    }
}

struct HalfBall: View {
    @State var isRotate = false
    @State var isScale = false
    var color:Color
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.7)
            .stroke(color, style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            .rotationEffect(Angle(degrees: isRotate ? 360 : 0))
            .scaleEffect(isScale ? 0.5 : 1)
            .onAppear {
                withAnimation(.linear(duration: 1.0).repeatForever(autoreverses:false)) {
                    isRotate = true
                }
                
                withAnimation(.linear(duration: 1.0).repeatForever()) {
                    isScale = true
                }
            }
    }
}

struct CircleStroke: View {
    
    @State private var isAnimating: Bool = false
    var color:Color
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            Circle()
                .trim(from: 0.0, to: 0.7)
                .stroke(color, style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                .animation(Animation
                    .timingCurve(0.5, 0.15, 0.25, 1, duration: 1.5)
                    .repeatForever(autoreverses: false),value: isAnimating)
            
            
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
}
