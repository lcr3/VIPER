//
//  MockWeatherListRouter.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

import UIKit
@testable import VIPER

class MockWeatherListRouter: WeatherListWireframe {
    var callCountShowWeatherDetail = 0

    func showWeatherDetail(forecasts: [Forcast]) {
        callCountShowWeatherDetail += 1
    }
}
