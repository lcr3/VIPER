//
//  WeatherListPresenterTests.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

import XCTest
@testable import VIPER

class WeatherListPresenterTests: XCTestCase {

    // 依存するクラスの初期化
    let view = MockWeatherListView()
    let interactor = MockWeatherListInteractor()
    let router = MockWeatherListRouter()
    var presenter: WeatherListPresenter!

    override func setUpWithError() throws {
        super.setUp()
        presenter = WeatherListPresenter(view: view,
                                         interactor: interactor,
                                         router: router)
        interactor.output = presenter
        view.presenter = presenter
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testViewDidLoad() {
        // execute
        presenter.viewDidLoad()

        // verify
        XCTAssertEqual(interactor.callCountGetLocations, 1)
    }

    func testWeatherListCellTouched() {
        // execute
        presenter.weatherListCellTouched(forecasts: [])

        // verify
        XCTAssertEqual(router.callCountShowWeatherDetail, 1)
    }

    func testSuccessGetLocation() {
        // setup
        interactor.dummyWeather = TestExtensions.createWeatherObject()

        // execute
        interactor.getLocations()

        // verify
        XCTAssertEqual(interactor.callCountGetLocations, 1)
        XCTAssertEqual(view.callCountShowErrorAletView, 0)
        XCTAssertEqual(view.callCountShowWeatherData, 1)
    }

    func testFailureGetLocation() {
        // execute
        interactor.getLocations()

        // verify
        XCTAssertEqual(interactor.callCountGetLocations, 1)
        XCTAssertEqual(view.callCountShowErrorAletView, 1)
        XCTAssertEqual(view.callCountShowWeatherData, 0)
    }

}


