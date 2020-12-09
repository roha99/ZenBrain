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
    @State var settingsAngle = Angle(degrees: 0)
    
    @State var active = false
    @State var settings = false
    
    @AppStorage("goal_hours") var goal_hours: Int = 0
    @AppStorage("goal_minutes") var goal_minutes: Int = 0
    @AppStorage("goal_seconds") var goal_seconds: Int = 10
    
    @State var actual_hours: Int = 0
    @State var actual_minutes: Int = 0
    @State var actual_seconds: Int = 0
    
    let timer = Timer.publish(every: 1, tolerance: 0, on: .main, in: .common).autoconnect()
    
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
                        #if os(iOS)
                        UIApplication.shared.isIdleTimerDisabled = false
                        #endif
                    } else {
                        self.progressAngle.degrees += 360
                        AudioServicesPlaySystemSound(SystemSoundID(1113))
                        #if os(iOS)
                        UIApplication.shared.isIdleTimerDisabled = true
                        #endif
                    }
                    self.active.toggle()
                }
                
                Spacer()
                
                Image(systemName: "gearshape")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                    .opacity(0.8)
                    .rotationEffect(self.settingsAngle)
                    .animation(.spring())
                    .onTapGesture {
                        if Bool.random() {
                            self.settingsAngle.degrees -= 360
                        } else {
                            self.settingsAngle.degrees += 360
                        }
                        self.settings.toggle()
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
        .onReceive(timer) { _ in
            
            if active {
                
                self.actual_seconds += 1
                
                if self.actual_seconds == 60 {
                    
                    self.actual_seconds = 0
                    self.actual_minutes += 1
                    
                }
                
                if self.actual_minutes == 60 {
                    
                    self.actual_minutes = 0
                    self.actual_hours += 1
                    
                }
                
            }
            
            if self.goal_hours == 0 && self.goal_minutes == 0 && self.goal_seconds == 0 {
                self.goal_seconds = 1
            }
            
            if self.actual_hours == self.goal_hours && self.actual_minutes == self.goal_minutes && self.actual_seconds == self.goal_seconds {
                
                AudioServicesPlaySystemSound(SystemSoundID(1310))
                
            }
            
        }
        
    }
    
}

struct TimerViewPreviews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
