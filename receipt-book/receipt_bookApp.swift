//
//  receipt_bookApp.swift
//  receipt-book
//
//  Created by Luis Zarza on 2023-10-18.
//

import SwiftUI

@main
struct receipt_bookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
// ESTO ES UN COMENTARIO
//PRUEBA

