//
//  ContentView.swift
//  Calculator
//
//  Created by Afraz Siddiqui on 3/5/21.
//

import SwiftUI

// MARK: - CalcButton

enum CalcButton: String {
  case one = "1"
  case two = "2"
  case three = "3"
  case four = "4"
  case five = "5"
  case six = "6"
  case seven = "7"
  case eight = "8"
  case nine = "9"
  case zero = "0"
  case add = "+"
  case subtract = "-"
  case divide = "÷"
  case multiply = "x"
  case equal = "="
  case clear = "AC"
  case decimal = "."
  case percent = "%"
  case negative = "+/-"

  // MARK: Internal

  var buttonColor: Color {
    switch self {
    case .add, .subtract, .multiply, .divide, .equal:
      return .orange
    case .clear, .negative, .percent:
      return Color(.lightGray)
    default:
      return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
    }
  }
}

// MARK: - Operation

enum Operation {
  case add, subtract, multiply, divide, none
}

// MARK: - ContentView

struct ContentView: View {

  @State var value = "0"
  @State var runningNumber = 0
  @State var currentOperation: Operation = .none

  let buttons: [[CalcButton]] = [
    [.clear, .negative, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .subtract],
    [.one, .two, .three, .add],
    [.zero, .decimal, .equal]
  ]

  var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)

      VStack {
        Spacer()

        // Text display
        HStack {
          Spacer()
          Text(value)
            .bold()
            .font(.system(size: 100))
            .foregroundColor(.white)
        }
        .padding()

        // Our buttons
        ForEach(buttons, id: \.self) { row in
          HStack(spacing: 12) {
            ForEach(row, id: \.self) { item in
              Button(action: {
                didTap(button: item)
              }, label: {
                Text(item.rawValue)
                  .font(.system(size: 32))
                  .frame(
                    width: buttonWidth(item: item),
                    height: buttonHeight())
                  .background(item.buttonColor)
                  .foregroundColor(.white)
                  .cornerRadius(20)
              })
            }
          }
          .padding(.bottom, 3)
        }
      }
    }
  }

  func didTap(button: CalcButton) {
    switch button {
    case .add, .subtract, .multiply, .divide:
      runningNumber = Int(value) ?? 0
      value = "0"
      if button == .add {
        currentOperation = .add
      } else if button == .subtract {
        currentOperation = .subtract
      } else if button == .multiply {
        currentOperation = .multiply
      } else if button == .divide {
        currentOperation = .divide
      }
    case .equal:
      switchCurrentOperation()
    case .clear:
      value = "0"
    case .decimal, .negative, .percent:
      break
    default:
      let number = button.rawValue
      if value == "0" {
        value = number
      } else {
        value = "\(value)\(number)"
      }
    }
  }

  func switchCurrentOperation() {
    let runningValue = runningNumber
    let currentValue = Int(value) ?? 0
    switch currentOperation {
    case .add: value = "\(runningValue + currentValue)"
    case .subtract: value = "\(runningValue - currentValue)"
    case .multiply: value = "\(runningValue * currentValue)"
    case .divide: value = "\(runningValue / currentValue)"
    case .none:
      break
    }
  }

  func buttonWidth(item: CalcButton) -> CGFloat {
    if item == .zero {
      return ((UIScreen.main.bounds.width - (3 * 12)) / 4) * 2
    }
    return (UIScreen.main.bounds.width - (5 * 12)) / 4
  }

  func buttonHeight() -> CGFloat {
    (UIScreen.main.bounds.width - (5 * 12)) / 4 * 0.9
  }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
