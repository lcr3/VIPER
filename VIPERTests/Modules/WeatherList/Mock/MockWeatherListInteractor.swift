//
//  MockWeatherListInteractor.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

@testable import VIPER

class MockWeatherListInteractor: WeatherListUsecase {
    var output: WeatherListInteractorOutput?
    var successFlag = false

    var dummyWeather: Weather?
    var callCountGetLocations = 0

    func getLocations() {
        callCountGetLocations += 1
        if let weather = dummyWeather {
            output?.getSuccess(weather: weather)
        } else {
            output?.getFailure(error: APIError.responseParseError)
        }
    }
}

class MockWeatherListInteractorOutput: WeatherListInteractorOutput {
    var callCountGetSuccess = 0
    var callCountGetFailure = 0

    func getSuccess(weather: Weather) {
        callCountGetSuccess += 1
    }

    func getFailure(error: Error) {
        callCountGetFailure += 1
    }
}
