//
//  ContentView.swift
//  Calculator
//
//  Created by Afraz Siddiqui on 3/5/21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

  @StateObject var viewModel = ViewModel()
  @State var currentOperation: Operation = .none
  @State private var rawOrientation = 1

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
      Group {
        switch rawOrientation {
        case 3, 4:
          LandscapeCalculatorView(viewModel: viewModel,
                                  buttons: buttons)
        default:
          PortraitCalculatorView(viewModel: viewModel,
                                 buttons: buttons)
        }
      }
      .onReceive(
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
          if UIDevice.current.orientation.rawValue != 2 {
            rawOrientation = UIDevice.current.orientation.rawValue
          }
        }
    }
  }

}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
