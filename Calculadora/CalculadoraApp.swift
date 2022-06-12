//
//  CalculadoraApp.swift
//  Calculadora
//
//  Created by Diosenelth De la hoz Fonseca on 10/06/22.
//

import SwiftUI

@main
struct CalculadoraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GlobalEnviroment())
        }
    }
}
