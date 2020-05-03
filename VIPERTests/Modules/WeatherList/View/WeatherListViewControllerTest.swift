//
//  WeatherListViewControllerTest.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

import XCTest
@testable import VIPER

class WeatherListViewControllerTest: XCTestCase {

    var weatherListViewController: WeatherListViewController!
    var presenter = MockWeatherListPresenter()

    override func setUpWithError() throws {
        self.setUp()
        weatherListViewController = WeatherListViewController.instantiate()
        weatherListViewController.presenter = presenter
        mainWindow?.rootViewController = weatherListViewController
        mainWindow?.makeKeyAndVisible()
    }

    override func tearDownWithError() throws {
        self.tearDown()
    }

    func testTableViewDidSelect() {
        // setup
        let tapIndexPath = IndexPath(row: 0, section: 0)

        // execute
        weatherListViewController.tableView(weatherListViewController.tableView,
                                            didSelectRowAt: tapIndexPath)

        // verify
        XCTAssertEqual(presenter.callCountWeatherListCellTouched, 1)
    }

    func testShowWeatherData() {
        // execute
        weatherListViewController.showWeatherData(weather: TestExtensions.createWeatherObject())

        // verify
        XCTAssertEqual(weatherListViewController.locationTitleLabel.text, "テスト")
        XCTAssertEqual(weatherListViewController.locationDescLabel.text, "タイトル")
    }

    func testShowErrorAletView() {
        // setup
        let errorMessage = "テストエラー"

        // execute
        weatherListViewController.showErrorAletView(errorMessage: errorMessage)

        guard let presented = weatherListViewController.presentedViewController,
            let alert = presented as? UIAlertController else {
            XCTFail("alset is nil")
            return
        }

        // verify
        XCTAssertEqual(alert.title, "エラー")
        XCTAssertEqual(alert.message, errorMessage)

    }
}
