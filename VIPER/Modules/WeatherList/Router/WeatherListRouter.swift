//
//  WeatherListRouter.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

protocol WeatherListWireframe {
    func showWeatherDetail(forecasts: [Forcast])
}

class WeatherListRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = WeatherListViewController.instantiate()
        let router = WeatherListRouter(viewController: view)
        let interector = WeatherListInteractor()
        let presenter = WeatherListPresenter(view: view,
                                             interactor: interector,
                                             router: router)
        view.presenter = presenter    // ViewにPresenterを設定
        interector.output = presenter

        return view
    }
}

extension WeatherListRouter: WeatherListWireframe {
    func showWeatherDetail(forecasts: [Forcast]) {
        let weatherDetailView = WeatherDetailRouter.assembleModules(forecasts: forecasts)
        viewController.navigationController?.present(weatherDetailView,
                                                     animated: true)
    }
}
