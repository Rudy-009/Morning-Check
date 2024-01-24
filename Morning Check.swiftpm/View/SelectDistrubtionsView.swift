//
//  SwiftUIView.swift
//  
//
//  Created by 이승준 on 1/20/24.
//

import SwiftUI

let columnLayout = Array(repeating: GridItem(), count: 3)

struct SelectDistrubtorsView: View {
    
    @Binding var selection: Set<SleepDisruptors>
    @Binding var times: Int
    let allDistruptors: [SleepDisruptors] = [
        .noise, .light,
        .phone,
        .meal, .snack, .drug, .protein,
        .alcohol, .caffein,
        .energyDrink
    ]
    
    var body: some View {
        VStack {
//            Text("Please select if there are any factors that may disrupt sleep.")
//                .font(.system(size: 45))
            ScrollView {
                LazyVGrid(columns: columnLayout) { 
                    ForEach(allDistruptors, id: \.rawValue) { distruptor in
                        DistruptionSelectedButton(selection: $selection, distruptor: distruptor)
                    }
                    howManyTimesWakesWhileSleeping(times: $times)
                }
            }
        }
    }
}

struct DistruptionSelectedButton: View {
    
    @Binding var selection: Set<SleepDisruptors>
    @State var selected: Bool = false
    
    let distruptor: SleepDisruptors
    var emoji: String {
        return distruptorEmoji(of: distruptor)
    }
    
    var body: some View {
        Button {
            if selected { //true => remove => false
                self.selection.remove(distruptor)
                print(selection)
            } else { //false => insert => true
                self.selection.insert(distruptor)
                print(selection)
            }
            selected.toggle()
        } label: {
            ZStack {
                VStack {
                    Text("\(explanationDis(of: distruptor))")
                    Text("\(emoji)")
                        .font(.system(size: 70))
                    Text("\(String(distruptor.rawValue).uppercased())")
                        .foregroundStyle(.selection)
                }
                if selected {
                    Image(systemName: "checkmark.circle")
                        .foregroundStyle(.blue)
                        .scaledToFit()
                        .font(.system(size: 60))
                }
            }
            .padding(30)
        }
    }
    
}

struct howManyTimesWakesWhileSleeping: View {
    @Binding var times: Int
    let betweenButton: CGFloat = 25
    let heightOfButton: CGFloat = 25
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("he number of awakenings")
            Text("during sleep")
            Text("\(times)")
                .font(.system(size: 60))
                .padding([.bottom], 0)
            HStack{
                Button{
                    times -= 1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundStyle(times <= 0 ? .gray : .white)
                        .scaledToFit()
                        .font(.system(size: heightOfButton))
                        .padding([.top], 0)
                }
                .disabled(times <= 0)
                .padding([.top], 0)
                .padding([.trailing], betweenButton)
                Button{
                    times += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.foreground)
                        .scaledToFit()
                        .font(.system(size: heightOfButton))
                        .padding([.top], 0)
                }
                .padding([.top], 0)
                .padding([.leading], betweenButton)
            }
            .padding([.top], 0)
        }
    }
}

#Preview {
    SelectDistrubtorsView(selection: .constant([]), times: .constant(3))
}
