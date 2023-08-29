//
//  States.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 28.08.2023.
//

import Foundation

enum States {
    enum LoadingStates: Equatable {
        
        static func == (lhs: States.LoadingStates, rhs: States.LoadingStates) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle):
                return true
            case (.loading, .loading):
                return true
            case (.failed(let lhsType), .failed(let rhsType)):
                return true
            case (.loaded, .loaded):
                return true
            default:
                return false
            }
        }
        
        case idle
        case loading
        case failed(NetworkService.FailureReason)
        case loaded
    }
}
