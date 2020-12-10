//
//  ZenBrainApp.swift
//  ZenBrain
//
//  Created by Robert Hansen on 09.12.20.
//

import SwiftUI
import AVFoundation

@main
struct ZenBrainApp: App {
    
    let timer = Timer.publish(every: 1, tolerance: 0, on: .main, in: .common).autoconnect()
    
    @State var active: Bool = false
    
    @AppStorage("goal_hours") var goal_hours: Int = 0
    @AppStorage("goal_minutes") var goal_minutes: Int = 1
    @AppStorage("goal_seconds") var goal_seconds: Int = 0
    
    @State var actual_hours: Int = 0
    @State var actual_minutes: Int = 0
    @State var actual_seconds: Int = 0
    
    @AppStorage("welcomed") var welcomed: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack{
            
                if self.welcomed {
                    TimerView(
                        active: self.$active,
                        goal_hours: self.$goal_hours,
                        goal_minutes: self.$goal_minutes,
                        goal_seconds: self.$goal_seconds,
                        actual_hours: self.$actual_hours,
                        actual_minutes: self.$actual_minutes,
                        actual_seconds: self.$actual_seconds
                    )
                } else {
                    OnboardingView(
                        welcomed: self.$welcomed,
                        active: self.$active,
                       goal_hours: self.$goal_hours,
                       goal_minutes: self.$goal_minutes,
                       goal_seconds: self.$goal_seconds,
                       actual_hours: self.$actual_hours,
                       actual_minutes: self.$actual_minutes,
                       actual_seconds: self.$actual_seconds
                    )
                }
                    
            }
            .onReceive(self.timer) { _ in
                
                if self.active {
                    
                    self.actual_seconds += 1
                    
                    if self.actual_seconds == 60 {
                        
                        self.actual_seconds = 0
                        self.actual_minutes += 1
                        
                    }
                    
                    if self.actual_minutes == 60 {
                        
                        self.actual_minutes = 0
                        self.actual_hours += 1
                        
                    }
                    
                    if self.actual_hours == self.goal_hours && self.actual_minutes == self.goal_minutes && self.actual_seconds == self.goal_seconds {
                        
                        AudioServicesPlaySystemSound(SystemSoundID(1310))
                        
                    }
                    
                }
                
                if self.goal_hours == 0 && self.goal_minutes == 0 && self.goal_seconds == 0 {
                    
                    self.goal_seconds = 1
                    
                }
                
            }
            
        }
        
    }
    
}
