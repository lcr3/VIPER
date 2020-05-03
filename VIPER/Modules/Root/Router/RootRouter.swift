//
//  RootRouter.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

protocol RootWireframe {
    func presentFirstScreen(in window: UIWindow)
}

class RootRouter: RootWireframe {
    func presentFirstScreen(in window: UIWindow) {
        let rootView = WeatherListRouter.assembleModules()
        window.rootViewController = UINavigationController(rootViewController: rootView)
        window.makeKeyAndVisible()
    }
}
