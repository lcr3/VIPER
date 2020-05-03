//
//  Weather.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

class Weather: Codable {
    var title: String
    var link: String
    var description: Description
    var pinpointLocations: [PinpointLocation]
    var location: Location
    var forecasts: [Forcast]

    // テスト用
    init(title: String, link: String, description: Description, pinpointLocations: [PinpointLocation], location: Location, forecasts: [Forcast]) {
        self.title = title
        self.link = link
        self.description = description
        self.pinpointLocations = pinpointLocations
        self.location = location
        self.forecasts = forecasts
    }
}

struct Description: Codable {
    var text: String
    var publicTime: String

    // テスト用
    init(text: String, publicTime: String) {
        self.text = text
        self.publicTime = publicTime
    }
}

struct PinpointLocation: Codable {
    var link: String
    var name: String

    // テスト用
    init(link: String, name: String) {
        self.link = link
        self.name = name
    }
}

struct Location: Codable {
    var city: String
    var area: String
    var prefecture: String

    // テスト用
    init(city: String, area: String, prefecture: String) {
        self.city = city
        self.area = area
        self.prefecture = prefecture
    }
}

struct Forcast: Codable {
    var dateLabel: String
    var telop: String
    var date: String
    var temperature: Temperature
    var image: Image

    // テスト用
    init(dateLabel: String, telop: String, date: String, temperature: Temperature, image: Image) {
        self.dateLabel = dateLabel
        self.telop = telop
        self.date = date
        self.temperature = temperature
        self.image = image
    }
}

struct Temperature: Codable {
    var min: Min?
    var max: Max?

    // テスト用
    init(min: Min?, max: Max?) {
        self.min = min
        self.max = max
    }
}

struct Min: Codable {
    var celsius: String

    // テスト用
    init(celsius: String) {
        self.celsius = celsius
    }
}

struct Max: Codable {
    var celsius: String

    // テスト用
    init(celsius: String) {
        self.celsius = celsius
    }
}


struct Image: Codable {
    var width: Int
    var url: String
    var title: String
    var height: Int

    // テスト用
    init(width: Int, url: String, title: String, height: Int) {
        self.width = width
        self.url = url
        self.title = title
        self.height = height
    }
}
