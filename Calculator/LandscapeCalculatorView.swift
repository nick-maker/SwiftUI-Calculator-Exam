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

  let buttons: [[CalcButton]]

  var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)
      HStack {
        leftCalculator
        centralButtons
        rightCalculator
      }
    }
  }

  var leftCalculator: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)

      VStack {
        Spacer()

        // Text display
        HStack {
          Spacer()
          Text(viewModel.valueLeft)
            .bold()
            .font(.system(size: 40))
            .foregroundColor(.white)
        }
        .padding(.horizontal, 40)

        HStack {
          Text(viewModel.calculationTextLeft)
            .font(.system(size: 25))
          .foregroundColor(.white)
          Spacer()
        }
        .padding(.horizontal)

        // Our buttons
        ForEach(buttons, id: \.self) { row in
          HStack {
            ForEach(row, id: \.self) { item in
              Button {
                viewModel.didTapLeft(button: item)
              } label: {
                Text(item.rawValue)
                  .font(.system(size: 20))
                  .frame(
                    width: buttonWidth(item: item),
                    height: buttonHeight())
                  .background(item.buttonColor)
                  .foregroundColor(.white)
                  .cornerRadius(10)
              }
            }
          }
        }
      }
    }
  }

  var centralButtons: some View {
    VStack {
      Spacer()
      Button {
        viewModel.leftArrowTap()
      } label: {
        Image(systemName: "arrowshape.left.fill")
          .foregroundColor(.white)
          .frame(width: buttonWidth(item: .add), height: buttonHeight())
          .background {
            RoundedRectangle(cornerRadius: 10)
              .fill(.green)
          }

      }
      Button {
        viewModel.rightArrowTap()
      } label: {
        Image(systemName: "arrowshape.right.fill")
          .foregroundColor(.white)
          .frame(width: buttonWidth(item: .add), height: buttonHeight())
          .background {
            RoundedRectangle(cornerRadius: 10)
              .fill(.green)
          }
      }
      Spacer()
      Button {

      } label: {
        Text("DEL")
          .foregroundColor(.white)
          .frame(width: buttonWidth(item: .add), height: buttonHeight())
          .background {
            RoundedRectangle(cornerRadius: 10)
              .fill(CalcButton.clear.buttonColor)
          }
      }

    }
  }

  var rightCalculator: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)
      VStack {
        Spacer()

        // Text display
        HStack {
          Spacer()
          Text(viewModel.valueRight)
            .bold()
            .font(.system(size: 40))
            .foregroundColor(.white)
        }
        .padding(.horizontal, 40)
        HStack {
          Text(viewModel.calculationTextRight)
            .font(.system(size: 25))
          .foregroundColor(.white)
          Spacer()
        }
        .padding(.horizontal)

        // Our buttons
        ForEach(buttons, id: \.self) { row in
          HStack {
            ForEach(row, id: \.self) { item in
              Button {
                viewModel.didTapRight(button: item)
              } label: {
                Text(item.rawValue)
                  .font(.system(size: 20))
                  .frame(
                    width: buttonWidth(item: item),
                    height: buttonHeight())
                  .background(item.buttonColor)
                  .foregroundColor(.white)
                  .cornerRadius(10)
              }
            }
          }
        }

      }
    }
  }

  private func buttonWidth(item: CalcButton) -> CGFloat {
    if item == .zero {
      return ((UIScreen.main.bounds.height / 2 - (5 * 5)) / 2.5 + 5) * 2
    }
    return (UIScreen.main.bounds.height / 2 - (5 * 5)) / 2.5
  }

  private func buttonHeight() -> CGFloat {
    (UIScreen.main.bounds.width / 2 - (6 * 5)) / 5 * 0.55
  }
}

// MARK: - LandscapeCalculatorView_Previews

struct LandscapeCalculatorView_Previews: PreviewProvider {
  static var previews: some View {
    LandscapeCalculatorView(viewModel: ViewModel(), buttons: [
      [.clear, .negative, .percent, .divide],
      [.seven, .eight, .nine, .multiply],
      [.four, .five, .six, .subtract],
      [.one, .two, .three, .add],
      [.zero, .decimal, .equal]
    ])
  }
}
