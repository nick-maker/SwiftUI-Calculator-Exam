//
//  LandscapeCalculatorView.swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/5.
//

import SwiftUI

// MARK: - LandscapeCalculatorView

struct LandscapeCalculatorView: View {

  @ObservedObject var viewModel: ViewModel
  @State var currentOperation: Operation
  @State var currentOperation2: Operation

  let buttons: [[CalcButton]]

  var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)
      HStack {
        ZStack {
          Color.black.edgesIgnoringSafeArea(.all)

          VStack {
            Spacer()

            // Text display
            HStack {
              Spacer()
              Text(viewModel.value)
                .bold()
                .font(.system(size: 40))
                .foregroundColor(.white)
            }
            .padding(.horizontal, 40)

            // Our buttons
            ForEach(buttons, id: \.self) { row in
              HStack {
                ForEach(row, id: \.self) { item in
                  Button(action: {
                    didTap(button: item)
                  }, label: {
                    Text(item.rawValue)
                      .font(.system(size: 20))
                      .frame(
                        width: buttonWidth(item: item),
                        height: buttonHeight())
                      .background(item.buttonColor)
                      .foregroundColor(.white)
                      .cornerRadius(10)
                  })
                }
              }
            }
          }
        }
        ZStack {
          Color.black.edgesIgnoringSafeArea(.all)
          VStack {
            Spacer()

            // Text display
            HStack {
              Spacer()
              Text(viewModel.value2)
                .bold()
                .font(.system(size: 40))
                .foregroundColor(.white)
            }
            .padding(.horizontal, 40)

            // Our buttons
            ForEach(buttons, id: \.self) { row in
              HStack {
                ForEach(row, id: \.self) { item in
                  Button(action: {
                    didTap(button: item)
                  }, label: {
                    Text(item.rawValue)
                      .font(.system(size: 20))
                      .frame(
                        width: buttonWidth(item: item),
                        height: buttonHeight())
                      .background(item.buttonColor)
                      .foregroundColor(.white)
                      .cornerRadius(10)
                  })
                }
              }
            }
          }
        }
      }
    }
  }

  func didTap(button: CalcButton) {
    switch button {
    case .add, .subtract, .multiply, .divide:
      viewModel.runningNumber = Double(viewModel.value) ?? 0.0
      viewModel.value = "0"
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
      viewModel.value = "0"
    case .decimal, .negative, .percent:
      break
    default:
      let number = button.rawValue
      if viewModel.value == "0" {
        viewModel.value = number
      } else {
        viewModel.value = "\(viewModel.value)\(number)"
      }
    }
  }

  func switchCurrentOperation() {
    let runningValue = viewModel.runningNumber
    let currentValue = Double(viewModel.value) ?? 0
    switch currentOperation {
    case .add: viewModel.value = "\(runningValue + currentValue)"
    case .subtract: viewModel.value = "\(runningValue - currentValue)"
    case .multiply: viewModel.value = "\(runningValue * currentValue)"
    case .divide: viewModel.value = "\(runningValue / currentValue)"
    case .none:
      break
    }
  }

  func buttonWidth(item: CalcButton) -> CGFloat {
    if item == .zero {
      return ((UIScreen.main.bounds.height / 2 - (5 * 5)) / 2.5 + 5) * 2
    }
    return (UIScreen.main.bounds.height / 2 - (5 * 5)) / 2.5
  }

  func buttonHeight() -> CGFloat {
    (UIScreen.main.bounds.width / 2 - (6 * 5)) / 5 * 0.55
  }
}

// MARK: - LandscapeCalculatorView_Previews

struct LandscapeCalculatorView_Previews: PreviewProvider {
  static var previews: some View {
    LandscapeCalculatorView(viewModel: ViewModel(), currentOperation: .none, currentOperation2: .none, buttons: [
      [.clear, .negative, .percent, .divide],
      [.seven, .eight, .nine, .multiply],
      [.four, .five, .six, .subtract],
      [.one, .two, .three, .add],
      [.zero, .decimal, .equal]
    ])
  }
}
