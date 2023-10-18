//
//  swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/6.
//

import Foundation

class ViewModel: ObservableObject {

  // MARK: - Left
  @Published var valueLeft: String = "0"
  @Published var calculationTextLeft = " "

  var runningNumberLeft: Double = 0.0
  var currentOperationLeft = Operation.none
  var isFinishedTypingNumberLeft = true

  func didTapLeft(button: CalcButton) {
    switch button {
    case .add, .subtract, .multiply, .divide:
      calcButtonPressedLeft(button: button)
    case .equal:
      switchLeftCurrentOperation()
    case .clear:
      valueLeft = "0"
      calculationTextLeft = " "
      currentOperationLeft = .none
      isFinishedTypingNumberLeft = true
    case .negative, .percent:
      otherButtonPressedLeft(button: button)
    default:
      numButtonPressedLeft(button: button)
    }
  }

  private func calcButtonPressedLeft(button: CalcButton) {
    runningNumberLeft = Double(valueLeft) ?? 0.0
    isFinishedTypingNumberLeft = true
    if currentOperationLeft == .equal {
      calculationTextLeft = valueLeft
    }
    if button == .add {
      currentOperationLeft = .add
      calculationTextLeft += " + "
    } else if button == .subtract {
      currentOperationLeft = .subtract
      calculationTextLeft += " - "
    } else if button == .multiply {
      currentOperationLeft = .multiply
      calculationTextLeft += " x "
    } else if button == .divide {
      currentOperationLeft = .divide
      calculationTextLeft += " / "
    }
  }

  private func numButtonPressedLeft(button: CalcButton) {
    let number = button.rawValue
    currentOperationLeft == .equal ? (calculationTextLeft = number) : (calculationTextLeft += number)
    if isFinishedTypingNumberLeft || currentOperationLeft == .equal {
      valueLeft = number
      isFinishedTypingNumberLeft = false
    } else {
      valueLeft = "\(valueLeft)\(number)"
    }
  }

  private func otherButtonPressedLeft(button: CalcButton) {
    let currentValue = Double(valueLeft) ?? 0
    switch button {
    case .negative:
      valueLeft = "\(currentValue * -1)"
      calculationTextLeft += " x -1"
    case .percent:
      valueLeft = "\(currentValue * 0.01)"
      calculationTextLeft += " x 0.01"
    default:
      return
    }
  }

  private func switchLeftCurrentOperation() {
    let runningValue = runningNumberLeft
    let currentValue = Double(valueLeft) ?? 0
    switch currentOperationLeft {
    case .add: valueLeft = "\(runningValue + currentValue)"
    case .subtract: valueLeft = "\(runningValue - currentValue)"
    case .multiply: valueLeft = "\(runningValue * currentValue)"
    case .divide: valueLeft = "\(runningValue / currentValue)"
    default:
      break
    }
    calculationTextLeft += " = \(valueLeft)"
    currentOperationLeft = .equal
  }

  // MARK: - Right
  @Published var valueRight: String = "0"
  @Published var calculationTextRight = " "

  var runningNumberRight: Double = 0.0
  var currentOperationRight = Operation.none
  var isFinishedTypingNumberRight = true

  func didTapRight(button: CalcButton) {
    switch button {
    case .add, .subtract, .multiply, .divide:
      calcButtonPressedRight(button: button)
    case .equal:
      switchRightCurrentOperation()
    case .clear:
      valueRight = "0"
      calculationTextRight = " "
      currentOperationRight = .none
      isFinishedTypingNumberRight = true
    case .negative, .percent:
      otherButtonPressedRight(button: button)
    default:
      numButtonPressedRight(button: button)
    }
  }

  private func calcButtonPressedRight(button: CalcButton) {
    runningNumberRight = Double(valueRight) ?? 0.0
    isFinishedTypingNumberRight = true
    if currentOperationRight == .equal {
      calculationTextRight = valueRight
    }
    if button == .add {
      currentOperationRight = .add
      calculationTextRight += " + "
    } else if button == .subtract {
      currentOperationRight = .subtract
      calculationTextRight += " - "
    } else if button == .multiply {
      currentOperationRight = .multiply
      calculationTextRight += " x "
    } else if button == .divide {
      currentOperationRight = .divide
      calculationTextRight += " / "
    }
  }

  private func numButtonPressedRight(button: CalcButton) {
    let number = button.rawValue
    currentOperationRight == .equal ? (calculationTextRight = number) : (calculationTextRight += number)
    if isFinishedTypingNumberRight || currentOperationRight == .equal {
      valueRight = number
      isFinishedTypingNumberRight = false
    } else {
      valueRight = "\(valueRight)\(number)"
    }
  }

  private func otherButtonPressedRight(button: CalcButton) {
    let currentValue = Double(valueRight) ?? 0
    switch button {
    case .negative:
      valueRight = "\(currentValue * -1)"
      calculationTextRight += " x -1"
    case .percent:
      valueRight = "\(currentValue * 0.01)"
      calculationTextRight += " x 0.01"
    default:
      return
    }
  }

  private func switchRightCurrentOperation() {
    let runningValue = runningNumberRight
    let currentValue = Double(valueRight) ?? 0
    switch currentOperationRight {
    case .add: valueRight = "\(runningValue + currentValue)"
    case .subtract: valueRight = "\(runningValue - currentValue)"
    case .multiply: valueRight = "\(runningValue * currentValue)"
    case .divide: valueRight = "\(runningValue / currentValue)"
    default:
      break
    }
    calculationTextRight += " = \(valueRight)"
    currentOperationRight = .equal
  }

  // MARK: - Central

  func leftArrowTap() {
    valueLeft = valueRight
    calculationTextLeft = valueRight
    currentOperationLeft = .equal
  }

  func rightArrowTap() {
    valueRight = valueLeft
    calculationTextRight = valueLeft
    currentOperationRight = .equal
  }
}
