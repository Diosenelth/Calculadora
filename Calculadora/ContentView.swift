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
    
    var title: String{
        switch self {
            case .one:return "1"
            case .two:return "2"
            case .three:return "3"
            case .four:return "4"
            case .five:return "5"
            case .six:return "6"
            case .seven:return "7"
            case .eight: return "8"
            case .nine:return "9"
            case .zero:return "0"
            case .plus:return "+"
            case .minus:return "-"
            case .percent:return "%"
            case .divide:return "/"
            case .equals:return "="
            case .multiply:return "X"
            case .ac:return "AC"
            case .doc:return "."
            case .plusminus: return "+/-"
        }
    }
    
    var BackgroundColor:Color{
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



struct ContentView: View {
    let buttons:[[CalculatorButton]] = [
        [.ac, .plusminus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .doc, .equals],
    ]
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing:12){
            HStack{
                Spacer()
                Text("0")
                .foregroundColor(.white)
                .font(.system(size:64))
            }.padding()

            ForEach(buttons, id: \.self){row in
                HStack (spacing:12){
                    ForEach(row, id: \.self){button in
                        Text(button.title)
                            .font(.system(size: 32))
                            .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                            .foregroundColor(.white)
                            .background(button.BackgroundColor)
                            .cornerRadius(self.buttonWidth(button: button))
                    }
                }
            }
        }.padding(.bottom)
    }
    }
    func buttonWidth(button:CalculatorButton) -> CGFloat {
        if button == .zero{
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
