//
//  PowerAuthAppApp.swift
//  PowerAuthApp
//
//  Created by Roman Siro on 26.05.2026.
//

import SwiftUI

@main
struct PowerAuthAppApp: App {

    private let authService: AuthService

    init() {
        let service = AuthService()
        do {
            try service.configure()
        } catch {
            print("PowerAuth configuration failed: \(error)")
        }
        authService = service
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authService)
        }
    }
}
