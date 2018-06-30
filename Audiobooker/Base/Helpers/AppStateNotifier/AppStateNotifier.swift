//
//  AppStateNotifier.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

enum AppState {
    case active
    case notActive
    case unknown
}

protocol IAppStateNotifier {
    func appChangedState(to state: AppState)
    func register(listener: IAppStateListener)
}

class AppStateNotifier {
    private var listeners: [Weak<IAppStateListener>] = [Weak<IAppStateListener>]()
    
    static let shared: IAppStateNotifier = AppStateNotifier()
}

extension AppStateNotifier: IAppStateNotifier {
    func register(listener: IAppStateListener) {
        self.listeners.append(Weak(listener))
    }
    
    func appChangedState(to state: AppState) {
        switch state {
            case .active: self.notifyAppIsActive()
            case .notActive: self.notifyAppIsNonActive()
            case .unknown: self.notifyAppIsUnknown()
        }
    }
}

private extension AppStateNotifier {
    func notifyAppIsActive() {
        for weakObject in self.listeners {
            weakObject.value?.appBecomeActive()
        }
    }
    
    func notifyAppIsNonActive() {
        for weakObject in self.listeners {
            weakObject.value?.appBecomeNonActive()
        }
    }
    
    func notifyAppIsUnknown() {
        for weakObject in self.listeners {
            weakObject.value?.appBecomeUnknown()
        }
    }
}

struct Weak<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T) {
        self.value = value
    }
}
