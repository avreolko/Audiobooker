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
    private var listeners = NSHashTable<IAppStateListener>.weakObjects()
    
    static let shared: IAppStateNotifier = AppStateNotifier()
}

extension AppStateNotifier: IAppStateNotifier {
    func register(listener: IAppStateListener) {
        self.listeners.add(listener)
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
        for listener in self.listeners.allObjects {
            listener.appBecomeActive()
        }
    }
    
    func notifyAppIsNonActive() {
        for listener in self.listeners.allObjects {
            listener.appBecomeNonActive()
        }
    }
    
    func notifyAppIsUnknown() {
        for listener in self.listeners.allObjects {
            listener.appBecomeUnknown()
        }
    }
}
