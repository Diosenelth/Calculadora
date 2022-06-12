//
//  ContentView.swift
//  Calculadora
//
//  Created by Diosenelth De la hoz Fonseca on 10/06/22.
//

import SwiftUI

enum CalculatorButton: String {
    case one, two, three, four, five, six, seven, eight, nine, zero
    case plus, minus, percent, divide, equals, multiply
    case ac, doc, plusminus

    var title: String {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .zero: return "0"
        case .plus: return "+"
        case .minus: return "-"
        case .percent: return "%"
        case .divide: return "/"
        case .equals: return "="
        case .multiply: return "X"
        case .ac: return "AC"
        case .doc: return "."
        case .plusminus: return "+/-"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .doc:
            return Color(.darkGray)
        case .ac, .plusminus, .percent:
            return Color(.lightGray)
        case .divide, .multiply, .plus, .minus, .equals:
            return .orange
        }
    }
}

class GlobalEnviroment: ObservableObject {
    @Published var display = ""
    @Published var operation = ""
    @Published var num1 = ""

    func receiveInput(calcularButton: CalculatorButton) {
        if(calcularButton.title == "AC") {
            self.display = ""
            self.num1 = ""
        } else if calcularButton.title == "+" || calcularButton.title == "-" || calcularButton.title == "X" || calcularButton.title == "/" {
            if self.display != "" {
                if self.num1 == "" {
                    self.operation = calcularButton.title
                    self.num1 = self.display
                    self.display = ""
                } else {
                    self.operation = calcularButton.title
                }
            }
        } else if calcularButton.title == "=" {
            if self.operation != "" && self.display != "0" && self.display != "" && self.num1 != "" && self.num1 != "0" {
                let nu = Int(self.num1) ?? 0
                let nu2 = Int(self.display) ?? 0
                if self.operation == "+" {
                    self.display = String(nu + nu2)
                    self.num1 = ""
                } else if self.operation == "-" {
                    self.display = String(nu - nu2)
                    self.num1 = ""
                } else if self.operation == "X" {
                    self.display = String(nu * nu2)
                    self.num1 = ""
                } else if self.operation == "/" {
                    self.display = String(nu / nu2)
                    self.num1 = ""
                }
            }
        } else if calcularButton.title == "+/-" {
            var nu = Int(self.display) ?? 0
            nu = nu - (nu + nu)
            self.display = String(nu)

        } else if calcularButton.title == "%" {
            let nu = Double(self.display) ?? 0
            let nua = Double(nu / 100)
            self.display = String(nua)
        } else {
            self.display = self.display + calcularButton.title
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnviroment
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusminus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .doc, .equals],
    ]
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.num1)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()

                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {

                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }

}

struct CalculatorButtonView: View {

    var button: CalculatorButton

    @EnvironmentObject var env: GlobalEnviroment
    var body: some View {
        Button(action: {
            self.env.receiveInput(calcularButton: button)
        }) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
        }
    }
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(GlobalEnviroment())
            ContentView().environmentObject(GlobalEnviroment())
            ContentView().environmentObject(GlobalEnviroment())
        }
    }
}
