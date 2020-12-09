//
//  TimerView.swift
//  ZenBrain
//
//  Created by Robert Hansen on 07.12.20.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    
    @State var progressAngle = Angle(degrees: 0)
    @State var settings = false
    
    @Binding var active: Bool
    
    @Binding var goal_hours: Int
    @Binding var goal_minutes: Int
    @Binding var goal_seconds: Int
    
    @Binding var actual_hours: Int
    @Binding var actual_minutes: Int
    @Binding var actual_seconds: Int
    
    var body: some View {
        
        HStack{
            
            Spacer()
            
            VStack {
                
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
                    self.progressAngle.degrees -= 720
                    AudioServicesPlaySystemSound(SystemSoundID(1109))
                    self.active = false
                    self.actual_hours = 0
                    self.actual_minutes = 0
                    self.actual_seconds = 0
                }
                .onTapGesture(count: 1) {
                    if self.active {
                        self.progressAngle.degrees -= 360
                        AudioServicesPlaySystemSound(SystemSoundID(1114))
                        self.active = false
                        #if os(iOS)
                        UIApplication.shared.isIdleTimerDisabled = false
                        #endif
                    } else {
                        self.progressAngle.degrees += 360
                        AudioServicesPlaySystemSound(SystemSoundID(1113))
                        self.active = true
                        #if os(iOS)
                        UIApplication.shared.isIdleTimerDisabled = true
                        #endif
                    }
                }
                
                Spacer()
                
                Button(action: { self.settings = true }) {
                    Image(systemName: "gearshape")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                        .opacity(0.8)
                }
                .sheet(isPresented: self.$settings) {
                    SettingsView(
                        goal_hours: self.$goal_hours,
                        goal_minutes: self.$goal_minutes,
                        goal_seconds: self.$goal_seconds,
                        settings: self.$settings)
                    
                }
                
                Spacer()
                
            }
            
            Spacer()
            
        }
        
    }
    
}
