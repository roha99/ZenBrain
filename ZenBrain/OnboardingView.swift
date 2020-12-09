//
//  OnboardingView.swift
//  ZenBrain
//
//  Created by Robert Hansen on 09.12.20.
//

import SwiftUI
import AVFoundation

struct OnboardingView: View {
    
    @State var step = "start"
    @State var progressAngle = Angle(degrees: 0)
    
    @Binding var welcomed: Bool
    
    @Binding var active: Bool
    
    @Binding var goal_hours: Int
    @Binding var goal_minutes: Int
    @Binding var goal_seconds: Int
    
    @Binding var actual_hours: Int
    @Binding var actual_minutes: Int
    @Binding var actual_seconds: Int
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            VStack {
                
                Spacer()
            
                Text("Welcome to ZenBrain!")
                    .font(.largeTitle)
                
                Spacer()
                
                ProgressCircleView(
                    angle: self.$progressAngle,
                    goal_hours: self.$goal_hours,
                    goal_minutes: self.$goal_minutes,
                    goal_seconds: self.$goal_seconds,
                    actual_hours: self.$actual_hours,
                    actual_minutes: self.$actual_minutes,
                    actual_seconds: self.$actual_seconds
                )
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    self.active = false
                }
                .onTapGesture(count: 2) {
                    if self.step == "reset" {
                        self.progressAngle.degrees -= 720
                        AudioServicesPlaySystemSound(SystemSoundID(1109))
                        self.active = false
                        self.actual_hours = 0
                        self.actual_minutes = 0
                        self.actual_seconds = 0
                        self.welcomed = true
                    }
                }
                .onTapGesture(count: 1) {
                    if self.active {
                        if self.step == "pause" {
                            self.step = "reset"
                            self.active = false
                            self.progressAngle.degrees -= 360
                            AudioServicesPlaySystemSound(SystemSoundID(1114))
                        }
                    } else {
                        if self.step == "start" {
                            self.step = "pause"
                            self.active = true
                            self.progressAngle.degrees += 360
                            AudioServicesPlaySystemSound(SystemSoundID(1113))
                        }
                    }
                }
                
                Spacer()
                
                if self.step == "start" {
                    Text("tap to start the timer")
                } else if self.step == "pause" {
                    Text("tap again to pause the timer")
                } else if self.step == "reset" {
                    Text("double tap to reset the timer")
                } 
                
                Spacer()
                
            }
            
            Spacer()
        
        }
        
    }
    
}
