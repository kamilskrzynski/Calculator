//
//  ContentView.swift
//  Calculator
//
//  Created by Kamil Skrzyński on 30/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentValue: String = "81"
    
    let buttons = [
        ["AC", "+/-", "%", "÷"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ",", "="],
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Text(currentValue)
                        .foregroundColor(.white)
                        .font(.system(size: 72))
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Text(button)
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .semibold))
                                .frame(width: button == "0" ? (getButtonWidth() * 2 + 12) : getButtonWidth(), height: getButtonWidth())
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(getButtonWidth())
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    func getButtonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
