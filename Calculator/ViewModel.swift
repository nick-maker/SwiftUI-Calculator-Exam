//
//  swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/6.
//

import Foundation

class ViewModel: ObservableObject {

//  @Published var isRight = true

  // MARK: - Left
  @Published var valueLeft: String = "0"
  @Published var runningNumberLeft: Double = 0.0
  @Published var currentOperationLeft = Operation.none

  func didTapLeft(button: CalcButton) {
    switch button {
    case .add, .subtract, .multiply, .divide:
      runningNumberLeft = Double(valueLeft) ?? 0.0
      valueLeft = "0"
      if button == .add {
        currentOperationLeft = .add
      } else if button == .subtract {
        currentOperationLeft = .subtract
      } else if button == .multiply {
        currentOperationLeft = .multiply
      } else if button == .divide {
        currentOperationLeft = .divide
      }
    case .equal:
      switchLeftCurrentOperation()
    case .clear:
      valueLeft = "0"
    case .decimal, .negative, .percent:
      break
    default:
      let number = button.rawValue
      if valueLeft == "0" {
        valueLeft = number
      } else {
        valueLeft = "\(valueLeft)\(number)"
      }
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
    case .none:
      break
    }
  }

  // MARK: - Right
  @Published var valueRight: String = "0"
  @Published var runningNumberRight: Double = 0.0
  @Published var currentOperationRight = Operation.none

  func didTapRight(button: CalcButton) {
    switch button {
    case .add, .subtract, .multiply, .divide:
      runningNumberRight = Double(valueRight) ?? 0.0
      valueRight = "0"
      if button == .add {
        currentOperationRight = .add
      } else if button == .subtract {
        currentOperationRight = .subtract
      } else if button == .multiply {
        currentOperationRight = .multiply
      } else if button == .divide {
        currentOperationRight = .divide
      }
    case .equal:
      switchRightCurrentOperation()
    case .clear:
      valueRight = "0"
    case .decimal, .negative, .percent:
      break
    default:
      let number = button.rawValue
      if valueRight == "0" {
        valueRight = number
      } else {
        valueRight = "\(valueRight)\(number)"
      }
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
    case .none:
      break
    }
  }

}
