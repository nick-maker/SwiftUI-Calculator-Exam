//
//  SwiftUIView.swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/5.
//

import SwiftUI

struct PortraitCalculatorView: View {

  @ObservedObject var viewModel: ViewModel
  @State var currentOperation: Operation

  let buttons: [[CalcButton]]

  var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)

      VStack {
        Spacer()

        // Text display
        HStack {
          Spacer()
          Text(viewModel.value)
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
      return ((UIScreen.main.bounds.width - (3 * 12)) / 4) * 2
    }
    return (UIScreen.main.bounds.width - (5 * 12)) / 4
  }

  func buttonHeight() -> CGFloat {
    (UIScreen.main.bounds.width - (5 * 12)) / 4 * 0.9
  }
}

// MARK: - LandscapeCalculatorView_Previews

struct PortraitCalculatorView_Previews: PreviewProvider {
  static var previews: some View {
    PortraitCalculatorView(viewModel: ViewModel(), currentOperation: .none, buttons: [
      [.clear, .negative, .percent, .divide],
      [.seven, .eight, .nine, .multiply],
      [.four, .five, .six, .subtract],
      [.one, .two, .three, .add],
      [.zero, .decimal, .equal]
    ]
    )
  }
}
