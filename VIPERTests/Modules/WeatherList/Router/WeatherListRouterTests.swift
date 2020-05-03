//
//  WeatherListRouterTests.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

import XCTest
@testable import VIPER

class WeatherListRouterTests: XCTestCase {

    var router: WeatherListRouter!

    override func setUpWithError() throws {
        self.setUp()
        let weatherListView = WeatherListRouter.assembleModules()
        mainWindow?.rootViewController = UINavigationController(rootViewController: weatherListView)
        mainWindow?.makeKeyAndVisible()
        router = WeatherListRouter(viewController: weatherListView)
    }

    override func tearDownWithError() throws {
        self.tearDown()
    }

    func testShowWeatherDetail() {
        // execute
        router.showWeatherDetail(forecasts: [])

        guard let main = mainWindow?.rootViewController as? UINavigationController else {
            XCTFail("UINavigationController not found")
            return
        }

        guard let weatherDetailViewController = main.topViewController?.presentedViewController as? WeatherDetailViewController else {
            XCTFail("WeatherDetailViewController not found")
            return
        }

        // verify
        XCTAssertNotNil(weatherDetailViewController)
    }
}
