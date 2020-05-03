//
//  TestExtensions.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

import XCTest
@testable import VIPER

extension XCTestCase {
    func delay(seconds: Float) {
        let delay = self.expectation(description: "delay finished")
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(seconds)) {
            delay.fulfill()
        }
        self.waitForExpectations(timeout: TimeInterval(seconds + 1.0))
    }
}

class TestExtensions {
    static func createWeatherObject() -> Weather {
        let description = Description(text: "タイトル",
                                      publicTime: "2020/05/02")
        let pinpointLocations = [PinpointLocation(link: "https",
                                                  name: "大牟田市"),
                                 PinpointLocation(link: "https",
                                                  name: "久留米市")]
        let location = Location(city: "久留米",
                                area: "九州",
                                prefecture: "福岡県")
        let temperature = Temperature(min: nil,
                                      max: Max(celsius: "20"))
        let image = Image(width: 10,
                          url: "https",
                          title: "晴れ",
                          height: 10)
        let forecasts = [Forcast(dateLabel: "今日",
                                 telop: "晴れ",
                                 date: "2020/05/02",
                                 temperature: temperature,
                                 image: image)]
        let weather = Weather(title: "テスト",
                              link: "https:",
                              description: description,
                              pinpointLocations: pinpointLocations, location: location,
                              forecasts: forecasts)
        return weather
    }
}
