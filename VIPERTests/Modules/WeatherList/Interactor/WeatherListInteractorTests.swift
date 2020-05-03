//
//  WeatherListInteractorTests.swift
//  VIPERTests
//
//  Created by okano on 2020/05/02.
//

@testable import VIPER
import OHHTTPStubs
import XCTest

class WeatherListInteractorTests: XCTestCase {

    var interactor: WeatherListInteractor!
    var output = MockWeatherListInteractorOutput()

    override func setUpWithError() throws {
        self.setUp()
        HTTPStubs.removeAllStubs()

        interactor = WeatherListInteractor()
        interactor.output = output
    }

    override func tearDownWithError() throws {
        self.tearDown()
        HTTPStubs.removeAllStubs()
    }

    func testSuccessGetLocations() {

        // setup
        stub(condition: pathEndsWith("/forecast/webservice/json/v1")) { _ in
            // 返ってくるJSONObjectを指定する
            let responseObject: [String: Any] = self.createJsonObject()
            return HTTPStubsResponse(jsonObject: responseObject, statusCode: 200, headers: nil)
        }

        // execute
        interactor.getLocations()
        self.delay(seconds: 1)

        // verify
        XCTAssertEqual(output.callCountGetSuccess, 1)
        XCTAssertEqual(output.callCountGetFailure, 0)
    }

    func testFailureGetLocations() {

        // setup
        stub(condition: pathEndsWith("/forecast/webservice/json/v1")) { _ in

        // 誤ったJSONObjectを指定する
        let obj = ["key1":"value1", "key2":["value2A","value2B"]] as [String : Any]
          return HTTPStubsResponse(jsonObject: obj, statusCode: 500, headers: nil)
        }

        // execute
        interactor.getLocations()
        self.delay(seconds: 1)

        // verify
        XCTAssertEqual(output.callCountGetSuccess, 0)
        XCTAssertEqual(output.callCountGetFailure, 1)
    }

    // JSONオブジェクトを作成
    private func createJsonObject() -> [String: Any] {
       return [
            "pinpointLocations": [
                [
                    "link": "http://weather.livedoor.com/area/forecast/4020200",
                    "name": "大牟田市"
                ],
                [
                    "link": "http://weather.livedoor.com/area/forecast/4054400",
                    "name": "広川町"
                ]
            ],
            "link": "http://weather.livedoor.com/area/forecast/400040",
            "forecasts": [
                [
                    "dateLabel": "今日",
                    "telop": "晴のち曇",
                    "date": "2020-05-02",
                    "temperature": [
                        "min": nil,
                        "max": nil
                    ],
                    "image": [
                        "width": 50,
                        "url": "http://weather.livedoor.com/img/icon/5.gif",
                        "title": "晴のち曇",
                        "height": 31
                    ]
                ]
            ],
            "location": [
                "city": "久留米",
                "area": "九州",
                "prefecture": "福岡県"
            ],
            "publicTime": "2020-05-02T17:00:00+0900",
            "copyright": [
                "provider": [
                    [
                        "link": "http://tenki.jp/",
                        "name": "日本気象協会"
                    ]
                ],
                "link": "http://weather.livedoor.com/",
                "title": "(C) LINE Corporation",
                "image": [
                    "width": 118,
                    "link": "http://weather.livedoor.com/",
                    "url": "http://weather.livedoor.com/img/cmn/livedoor.gif",
                    "title": "livedoor 天気情報",
                    "height": 26
                ]
            ],
            "title": "福岡県 久留米 の天気",
            "description": [
                "text": " 福岡県は、高気圧に覆われて概ね晴れとなっています。\n\n 2日は、高気圧に覆われてはじめ晴れとなりますが、気圧の谷や湿った空気の影響により夜は曇りで、雨の降る所があるでしょう。\n\n 3日は、前線や低気圧の影響により雨や曇りで、雷を伴う所があるでしょう。\n\n<天気変化等の留意点>\n 筑後北部では、2日18時から3日18時までに予想される降水量は、多い所で1時間に15ミリ、24時間に50ミリの見込みです。",
                "publicTime": "2020-05-02T16:37:00+0900"
            ]
        ]
    }
}
