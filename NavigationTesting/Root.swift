//
//  Root.swift
//  NavigationTesting
//
//  Created by Mikhail Kalatsei on 20/08/2024.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct RootFeature {
    @ObservableState
    public struct State {
        var path = StackState<Path.State>()
    }

    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
    }

    public var body: some ReducerOf<Self>{
        Reduce { state, action in
            switch action {
            case let .path(.element(id: _, action: action)):
                switch action{
                case .screen1(let screen1Action):
                    switch screen1Action {
                    case .showScreen2:
                        state.path.append(.screen2(Screen2Feature.State()))
                    case .changeName(_):
                        return .none
                    case .showScreen3:
                        state.path.append(.screen3(Screen3Feature.State()))
                    }
                case .screen2(_):
                    return .none
                case .screen3(_):
                    return .none
                }
                return .none
            default:
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

public struct RootView: View {

    @Bindable var store: StoreOf<RootFeature>

    init(store: StoreOf<RootFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            Form {
                NavigationLink(
                    state: RootFeature.Path.State.screen1(Screen1Feature.State())
                ) {
                    Text("Detail")
                }
            }
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
