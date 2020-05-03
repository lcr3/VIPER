//
//  MockWeatherListView.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

import UIKit
@testable import VIPER

class MockWeatherListView: WeatherListView {
    var presenter: WeatherListPresentation!

    var callCountShowWeatherData = 0
    var callCountShowErrorAletView = 0

    func showWeatherData(weather: Weather) {
        callCountShowWeatherData += 1
    }

    func showErrorAletView(errorMessage: String) {
        callCountShowErrorAletView += 1
    }
}
