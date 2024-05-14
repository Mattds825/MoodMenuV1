//
//  PopoverView.swift
//  MoodMenuV1
//
//  Created by Matt Da Silva on 14/05/2024.
//

import SwiftUI

struct PopoverView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [])
    
    var links: FetchedResults<MoodData>
    
    @State private var selected = 1
    
    @State private var selectedMood = Moods.red
    
    @State private var genMoodValue: Double = 1
    @State private var genMoodStep: Double = 1
    
    
    enum Moods: String, CaseIterable{
        case yellow, orange, red, blue, purple, green
        
    }
    
    @State var showingPopup = false // 1
    
    var body: some View {
        VStack{
            Text("Main Mood")
            
            
            Picker(selection: $selectedMood, label: Text("")) {
                        ForEach(Moods.allCases, id: \.self) { mood in
                           Text(getSymbol(mood))
                        }
                    }
                    .padding()
    //                .colorMultiply(color(selectedColor))
                    .pickerStyle(.palette)
            
            Text("General Mood")
            
            
            Slider(value: $genMoodValue, in: ClosedRange(uncheckedBounds: (1,10)), step: genMoodStep)
                .padding()
                .colorMultiply(color(selectedMood))
            
            Text("\(Int(genMoodValue))")
            
            
            HStack{
                Button(action: {
                    let moodData = MoodData(context: viewContext)
                    
                    moodData.id = UUID()
                    moodData.dateTime = Date.now
                    moodData.generalMood = Int16(genMoodValue)
                    moodData.moodType = getMoodInt(selectedMood)
                    moodData.note = ""
                    
                    try? viewContext.save()
                    
                    selectedMood = Moods.red
                    genMoodValue = 1
                    
                }, label: {
                    Text("Save")
                }).padding().colorMultiply(.green)
                Button(action: {
                    self.showingPopup = true
                }, label: {
                    Text("Logs")
                }).padding().colorMultiply(.gray)
            }
        }.popover(isPresented: $showingPopup, content: {
            VStack(content: {
                ForEach(links, id: \.wrappedID){link in
                    HStack{
//                        Text("\(link.wrappedID)")
                        Text("Date: \(link.wrappedDateTime.formatted())")
                        Text("Genral Mood: \(link.wrappedGeneralMood)")
//                        Text("\(link.wrappedMoodType)")
                        Rectangle()
                            .fill(getColorFromInt(link.wrappedMoodType))
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
//                        Text("\(link.wrappedGeneralMood)")
//                        Text("\(link.wrappedMoodType)")
//                        Text("\(link.wrappedDateTime.formatted(.numeric))")
                        
                    }.padding(.all)
                }
            }).padding(.all)
        })
                    
    }
    
    func getSymbol(_ selected:Moods) -> String{
        switch selected {
        case .yellow:
            return "🟨"
        case .orange:
            return "🟧"
        case .red:
            return "🟥"
        case .blue:
            return "🟦"
        case .purple:
            return "🟪"
        case .green:
            return "🟩"
        }
    }
    
    func color(_ selected: Moods) -> Color {
         switch selected {
         case .yellow:
             return .yellow
         case .orange:
             return .orange
         case .red:
             return .red
         case .blue:
             return .blue
         case .purple:
             return .purple
         case .green:
             return .green
         }
     }
    
    func getMoodInt(_ selected: Moods) -> Int16 {
         switch selected {
         case .yellow:
             return 1
         case .orange:
             return 2
         case .red:
             return 3
         case .blue:
             return 4
         case .purple:
             return 5
         case .green:
             return 6
         }
     }
    
    func getColorFromInt(_ moodNum: Int16) -> Color{
        switch moodNum{
        case 1:
            return .yellow
        case 2:
            return .orange
        case 3:
            return .red
        case 4:
            return .blue
        case 5:
            return .purple
        case 6:
            return .green
        default:
            return .black
        
        }
    }
}

#Preview {
    PopoverView()
}
