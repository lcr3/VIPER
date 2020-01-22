//
//  RouteRooter.swift
//  VIPER
//
//  Created by ryookano on 2020/01/14.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

class RootRouter {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func showFirstView() {
        let firstView = ArticleListRouter.assembleModules()
        let navigationController = UINavigationController(rootViewController: firstView)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
