//
//  SettingsView.swift
//  ZenBrain
//
//  Created by Robert Hansen on 07.12.20.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var goal_hours: Int
    @Binding var goal_minutes: Int
    @Binding var goal_seconds: Int
    
    @State var time: Date = Date()
    
    @Binding var settings: Bool
    
    let colors = ["Red", "Yellow", "Green", "Gray", "Black", "Purple", "White", "Brown", "Pink", "Blue"]
    @State private var color = "Red"
    
    var body: some View {
        
        NavigationView {
        
        Form {
            
            Section(header: Text("set your meditation goal")) {
                
                HStack {
                    
                    Spacer()
                    
                    Picker("hours", selection: $goal_hours) {
                        
                        ForEach(0..<24) { hour in
                            Text("\(hour)")
                        }
                        
                    }
                    .frame(width: 75)
                    .clipped()
                                   
                    
                    Picker("minutes", selection: $goal_minutes) {
                        
                        ForEach(0..<60) { minute in
                            Text("\(minute)")
                        }
                        
                    }
                    .frame(width: 75)
                    .clipped()
                            
                    
                    Picker("seconds", selection: $goal_seconds) {
                        
                        ForEach(0..<60) { second in
                            Text("\(second)")
                        }
                        
                    }
                    .frame(width: 75)
                    .clipped()
                                  
                    
                    Spacer()
                    

                }
                .pickerStyle(WheelPickerStyle())
                
                
                
            }
            
            Section(header: Text("let me know what you think")) {
                
                Link("@r0b3rth4ns3n", destination: URL(string: "https://twitter.com/r0b3rth4ns3n")!)
                
            }
            
        }
        .navigationTitle("Settings")
        .navigationBarItems(trailing: Button(action: { self.settings = false }, label: { Image(systemName: "umbrella").font(.title) }))
            
        }
        
    }
    
}
