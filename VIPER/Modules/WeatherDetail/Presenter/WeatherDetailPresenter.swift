//
//  WeatherDetailPresenter.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

protocol WeatherDetailPresentation {
}

class WeatherDetailPresenter {
    private weak var view: WeatherDetailView?
    private let router: WeatherDetailWireframe

    init(view: WeatherDetailView,
         router: WeatherDetailWireframe,
         forcasts: [Forcast]) {

        self.view = view
        self.view?.forecasts = forcasts
        self.router = router
    }
}

extension WeatherDetailPresenter: WeatherDetailPresentation {
}

