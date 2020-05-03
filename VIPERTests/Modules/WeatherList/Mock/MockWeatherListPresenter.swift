//
//  MockWeatherListPresenter.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

@testable import VIPER

class MockWeatherListPresenter: WeatherListPresentation {
    var callCountViewDidLoad = 0
    var callCountWeatherListCellTouched = 0

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }
    func weatherListCellTouched(forecasts: [Forcast]) {
        callCountWeatherListCellTouched += 1
    }
}
