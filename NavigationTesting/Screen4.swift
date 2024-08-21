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
struct Screen4Feature {
    @ObservableState
    public struct State {
        public var name: String = ""
        var path = StackState<Path.State>()

    }

    public enum Action {
        case changeName(String)
        case path(StackAction<Path.State, Path.Action>)
        case showScreen1
    }

    public var body: some ReducerOf<Self>{

        Reduce { state, action in
            switch action {
            case let .path(.element(id: _, action: action)):
                switch action {
                case .screen1(let screen1Action):
                    switch screen1Action{
                    case .showScreen2:
                        state.path.append(.screen2(Screen2Feature.State()))
                    case .showScreen3:
                        state.path.append(.screen3(Screen3Feature.State()))
                    default:
                        return .none
                    }
                    return .none
                default:
                    return .none
                }
            case .changeName(_):
                return .none
            case .path(_):
                return .none
            case .showScreen1:
                state.path.append(.screen1(Screen1Feature.State()))
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    @Reducer
    enum Path {
        case screen1(Screen1Feature)
        case screen2(Screen2Feature)
        case screen3(Screen3Feature)
    }
}

public struct Screen4: View {

    @Bindable var store: StoreOf<Screen4Feature>

    init(store: StoreOf<Screen4Feature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            Screen1(store: Store(initialState: Screen1Feature.State(), reducer: {Screen1Feature()}))
        } destination: { store in
            switch store.case {
            case .screen1(let store):
                Screen1(store: store)
            case .screen2(let store):
                Screen2(store: store)
            case .screen3(let store):
                Screen3(store: store)
            }
        }

    }
}
