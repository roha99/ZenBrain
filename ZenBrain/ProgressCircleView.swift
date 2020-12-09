//
//  ProgressCircleView.swift
//  ZenBrain
//
//  Created by Robert Hansen on 06.12.20.
//

import SwiftUI

let lineWidth: CGFloat = 30
let frameWidth: CGFloat = 210
let frameHeight: CGFloat = 210

struct ProgressCircleView: View {
    
    @Binding var angle: Angle
    
    @Binding var goal_hours: Int
    @Binding var goal_minutes: Int
    @Binding var goal_seconds: Int
    
    @Binding var actual_hours: Int
    @Binding var actual_minutes: Int
    @Binding var actual_seconds: Int
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(Color.secondary, lineWidth: lineWidth)
                .opacity(0.2)
            
            Circle()
                .trim(from: 0.0, to: progress())
                .stroke(color(), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(270))
                .animation(.linear)
            
            Text("\(actual_hours):\(actual_minutes):\(actual_seconds)")
                .font(.title)
                .bold()
                .foregroundColor(color())
                .rotationEffect(self.angle)
                .animation(.spring())
            
        }
        .frame(width: frameWidth, height: frameHeight)
        .padding()
        .contentShape(Circle())
        
    }
    
    func progress() -> CGFloat {
        let goal = CGFloat((goal_hours*60+goal_minutes)*60+goal_seconds)
        let actual = CGFloat((actual_hours*60+actual_minutes)*60+actual_seconds)
        return actual/goal
    }
    
    func color() -> Color {
        let p = progress()
        if p >= 0.75 { return .green }
        if p >= 0.5 { return .yellow }
        if p >= 0.25 { return .orange }
        return .red
    }
    
}
