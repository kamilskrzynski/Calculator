//
//  ContentView.swift
//  Calculator
//
//  Created by Kamil Skrzyński on 30/05/2022.
//

import SwiftUI

enum CalculatorButton: String {
    case clear = "AC"
    case negative = "+/-"
    case percentage = "%"
    case divide = "÷"
    case multiply = "*"
    case substract = "-"
    case add = "+"
    case equal = "="
    case decimal = ","
    case nine = "9"
    case eight = "8"
    case seven = "7"
    case six = "6"
    case five = "5"
    case four = "4"
    case three = "3"
    case two = "2"
    case one = "1"
    case zero = "0"
    
    var backgroundColor: Color {
        switch self {
        case .equal, .add, .substract, .multiply, .divide:
            return Color.orange
        case .clear, .negative, .percentage:
            return Color.gray
        default:
            return Color.gray.opacity(0.2)
        }
    }
    
    var width: CGFloat {
        switch self {
        case .zero:
            return (self.getButtonWidth() * 2) + 12
        default:
            return self.getButtonWidth()
        }
    }
    
    var height: CGFloat {
        return getButtonWidth()
    }
    
    func getButtonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView: View {
    
    @State private var currentValue: String = "81"
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percentage, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
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
                            Button {
                            } label: {
                                Text(button.rawValue)
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .semibold))
                                    .frame(width: button.width, height: button.height)
                                    .background(button.backgroundColor)
                                    .cornerRadius(button.height)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
