//
//  NavigationTestingApp.swift
//  NavigationTesting
//
//  Created by Mikhail Kalatsei on 07/08/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct NavigationTestingApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootFeature.State(), reducer: { RootFeature() }))
        }
    }
}
