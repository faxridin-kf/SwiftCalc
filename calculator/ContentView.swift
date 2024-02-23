import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Double = 0
    @State private var storedNumber: Double = 0
    @State private var storedOperation: Operation?
    @State private var isTyping = false
    
    enum Operation {
        case add, subtract, multiply, divide, none
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(String(format: "%.2f", currentNumber))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                CalculatorButton(text: "7", action: { self.appendNumber(7) })
                CalculatorButton(text: "8", action: { self.appendNumber(8) })
                CalculatorButton(text: "9", action: { self.appendNumber(9) })
                CalculatorButton(text: "÷", backgroundColor: .orange, action: { self.setOperation(.divide) })
            }
            
            HStack(spacing: 20) {
                CalculatorButton(text: "4", action: { self.appendNumber(4) })
                CalculatorButton(text: "5", action: { self.appendNumber(5) })
                CalculatorButton(text: "6", action: { self.appendNumber(6) })
                CalculatorButton(text: "×", backgroundColor: .orange, action: { self.setOperation(.multiply) })
            }
            
            HStack(spacing: 20) {
                CalculatorButton(text: "1", action: { self.appendNumber(1) })
                CalculatorButton(text: "2", action: { self.appendNumber(2) })
                CalculatorButton(text: "3", action: { self.appendNumber(3) })
                CalculatorButton(text: "-", backgroundColor: .orange, action: { self.setOperation(.subtract) })
            }
            
            HStack(spacing: 20) {
                CalculatorButton(text: "0", action: { self.appendNumber(0) })
                CalculatorButton(text: ".", action: { self.appendDecimal() })
                CalculatorButton(text: "=", backgroundColor: .orange, action: { self.calculate() })
                CalculatorButton(text: "+", backgroundColor: .orange, action: { self.setOperation(.add) })
            }
            
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    func appendNumber(_ number: Double) {
        if isTyping {
            currentNumber = currentNumber * 10 + number
        } else {
            currentNumber = number
            isTyping = true
        }
    }
    
    func appendDecimal() {
        guard !String(currentNumber).contains(".") else {
            return
        }
        currentNumber = currentNumber == 0 ? 0 : currentNumber
        currentNumber = currentNumber * 10 + 0.1
    }
    
    func setOperation(_ operation: Operation) {
        storedNumber = currentNumber
        currentNumber = 0
        storedOperation = operation
        isTyping = false
    }
    
    func calculate() {
        guard let operation = storedOperation else { return }
        
        switch operation {
        case .add:
            currentNumber = storedNumber + currentNumber
        case .subtract:
            currentNumber = storedNumber - currentNumber
        case .multiply:
            currentNumber = storedNumber * currentNumber
        case .divide:
            if currentNumber != 0 {
                currentNumber = storedNumber / currentNumber
            } else {
                // Handle division by zero error
                currentNumber = 0
            }
        case .none:
            break
        }
        storedOperation = nil
        isTyping = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalculatorButton: View {
    let text: String
    let backgroundColor: Color
    let action: () -> Void
    
    init(text: String, backgroundColor: Color = .gray, action: @escaping () -> Void) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title)
                .frame(width: 80, height: 80)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(40)
        }
    }
}
