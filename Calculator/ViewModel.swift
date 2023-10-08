//
//  ViewModel.swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/6.
//

import Foundation

class ViewModel: ObservableObject {

  @Published var value: String = "0"
  @Published var runningNumber: Double = 0.0

  @Published var value2: String = "0"
  @Published var runningNumber2: Double = 0.0
}
