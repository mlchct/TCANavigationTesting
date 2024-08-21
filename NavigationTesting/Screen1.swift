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
struct Screen1Feature {
    @ObservableState
    public struct State: Equatable {
        public var name: String = ""
    }

    public enum Action {
        case changeName(String)
        case showScreen2
        case showScreen3
    }

    public var body: some ReducerOf<Self>{

        Reduce { state, action in
            switch action {
            case .changeName(let name):
                state.name = name
                return .none
            case .showScreen2:
                return .none
            case .showScreen3:
                return .none
            }

        }
    }
}

public struct Screen1: View {

    @Bindable var store: StoreOf<Screen1Feature>

    init(store: StoreOf<Screen1Feature>) {
        self.store = store
    }

    public var body: some View {
        VStack{
            Button("Screen2") {
                store.send(.showScreen2)
            }
            Button("Screen3") {
                store.send(.showScreen3)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
    }
}
