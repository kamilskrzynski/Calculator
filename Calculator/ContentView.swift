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

enum CalculatorOperation {
    case add, substract, multiply, divide
}

struct ContentView: View {
    
    @State private var currentValue: String = "0"
    @State private var placeholder: String = "0"
    @State private var result: String = ""
    @State private var currentOperation: CalculatorOperation? = nil
    
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
                                buttonTapped(button: button)
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
    
    func buttonTapped(button: CalculatorButton) {
        switch button {
        case .clear:
            currentValue = "0"
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if currentValue == "0" {
                currentValue = button.rawValue
            } else {
                currentValue = currentValue + button.rawValue
            }
        case .add, .substract, .multiply, .divide:
            if button == .add {
                currentOperation = .add
                placeholder = currentValue
                currentValue = "0"
            } else if button == .substract {
                currentOperation = .substract
                placeholder = currentValue
                currentValue = "0"
            } else if button == .multiply {
                currentOperation = .multiply
                placeholder = currentValue
                currentValue = "0"
            } else if button == .divide {
                currentOperation = .divide
                placeholder = currentValue
                currentValue = "0"
            } else {
                currentOperation = nil
            }
        case .equal:
            switch currentOperation {
            case .add:
                result = String((Double(placeholder) ?? 0) + (Double(currentValue) ?? 0))
                if result.hasSuffix(".0") {
                    result.removeLast(2)
                }
                currentValue = result
            case .substract:
                result = String((Double(placeholder) ?? 0) - (Double(currentValue) ?? 0))
                if result.hasSuffix(".0") {
                    result.removeLast(2)
                }
                currentValue = result
            case .multiply:
                result = String((Double(placeholder) ?? 0) * (Double(currentValue) ?? 0))
                if result.hasSuffix(".0") {
                    result.removeLast(2)
                }
                currentValue = result
            case .divide:
                result = String((Double(placeholder) ?? 0) / (Double(currentValue) ?? 0))
                if result.hasSuffix(".0") {
                    result.removeLast(2)
                }
                currentValue = result
            case .none:
                break
            }
        case .negative:
            if currentValue.starts(with: "-") {
                currentValue.removeFirst()
            } else {
                currentValue = "-\(currentValue)"
            }
        case .percentage:
            let newResult = String((Double(result) ?? 0) * 100) + "%"
            currentValue = newResult
        default:
            break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
