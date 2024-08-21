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
struct Screen3Feature {
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


public struct Screen3: View {

    @Bindable var store: StoreOf<Screen3Feature>

    init(store: StoreOf<Screen3Feature>) {
        self.store = store
    }

    public var body: some View {
        Color(.blue)
            .ignoresSafeArea()
    }
}
