//
//  SwiftUIView.swift
//  Calculator
//
//  Created by Nick Liu on 2023/10/5.
//

import SwiftUI

struct PortraitCalculatorView: View {

  @ObservedObject var viewModel: ViewModel

  let buttons: [[CalcButton]]

  var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)

      VStack {
        Spacer()

        // Text display
        HStack {
          Spacer()
          Text(viewModel.valueRight)
            .bold()
            .font(.system(size: 100))
            .foregroundColor(.white)
        }
        .padding()

        // Our buttons
        ForEach(buttons, id: \.self) { row in
          HStack(spacing: 12) {
            ForEach(row, id: \.self) { item in
              Button {
                viewModel.didTapRight(button: item)
              } label: {
                Text(item.rawValue)
                  .font(.system(size: 32))
                  .frame(
                    width: buttonWidth(item: item),
                    height: buttonHeight())
                  .background(item.buttonColor)
                  .foregroundColor(.white)
                  .cornerRadius(20)
              }
            }
          }
          .padding(.bottom, 3)
        }
      }
    }
  }

  private func buttonWidth(item: CalcButton) -> CGFloat {
    if item == .zero {
      return ((UIScreen.main.bounds.width - (3 * 12)) / 4) * 2
    }
    return (UIScreen.main.bounds.width - (5 * 12)) / 4
  }

  private func buttonHeight() -> CGFloat {
    (UIScreen.main.bounds.width - (5 * 12)) / 4 * 0.9
  }
}

// MARK: - LandscapeCalculatorView_Previews

struct PortraitCalculatorView_Previews: PreviewProvider {
  static var previews: some View {
    PortraitCalculatorView(viewModel: ViewModel(), buttons: [
      [.clear, .negative, .percent, .divide],
      [.seven, .eight, .nine, .multiply],
      [.four, .five, .six, .subtract],
      [.one, .two, .three, .add],
      [.zero, .decimal, .equal]
    ]
    )
  }
}
