//
//  CounterViewReactor.swift
//  Counter-Prac
//
//  Created by 정종인 on 2020/06/06.
//  Copyright © 2020 swmaestro10th. All rights reserved.
//

import Foundation
import ReactorKit

class CounterViewReactor: Reactor {
    
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case isLoading(Bool)
    }
    
    struct State {
        var value: Int
        var isLoading: Bool
    }
    
    var initialState: State
    
    init() {
        self.initialState = State(value: 0, isLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.isLoading(true)),
                Observable.just(Mutation.increaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.isLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.isLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.isLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .decreaseValue:
            state.value -= 1
        case .isLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
