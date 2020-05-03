//
//  WeatherDetailRouter.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

protocol WeatherDetailWireframe {
}

class WeatherDetailRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules(forecasts: [Forcast]) -> UIViewController {
        let view = WeatherDetailViewController.instantiate()
        let router = WeatherDetailRouter(viewController: view)
        let presenter = WeatherDetailPresenter(view: view,
                                             router: router,
                                             forcasts: forecasts)
        view.presenter = presenter    // ViewにPresenterを設定

        return view
    }
}

extension WeatherDetailRouter: WeatherDetailWireframe {
}
