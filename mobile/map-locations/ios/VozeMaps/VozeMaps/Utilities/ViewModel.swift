//
//  ViewModel.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Combine
import Foundation

@dynamicMemberLookup
protocol ViewModel: ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    associatedtype State: Hashable
    var state: State { get set }
}

extension ViewModel {
    // Dynamic lookup lets us pretend `State` members are directly on the ViewModel
    subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        state[keyPath: keyPath]
    }
    
    /// Normally SwiftUI Views are updated  every state change. Using `update` improves performance by batching state changes.
    func update(_ batch: (inout State) -> Void) {
        var state = state
        batch(&state)
        self.state = state
    }
}
