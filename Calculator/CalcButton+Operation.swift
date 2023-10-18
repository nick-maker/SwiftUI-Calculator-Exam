//
//  CalcButton.swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/4.
//

import Foundation
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
  case add, subtract, multiply, divide, none, equal
}
