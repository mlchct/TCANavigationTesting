//
//  Screen1.swift
//  NavigationTesting
//
//  Created by Mikhail Kalatsei on 20/08/2024.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct Screen2Feature {
    @ObservableState
    public struct State: Equatable {
        public var name: String = ""
    }

    public enum Action {
        case changeName(String)
    }

    public var body: some ReducerOf<Self>{

        Reduce { state, action in
            switch action {
            case .changeName(let name):
                state.name = name
                return .none
            }
        }
    }
}

public struct Screen2: View {

    @Bindable var store: StoreOf<Screen2Feature>

    init(store: StoreOf<Screen2Feature>) {
        self.store = store
    }

    public var body: some View {
        Color(.cyan)
            .ignoresSafeArea()
    }
}
