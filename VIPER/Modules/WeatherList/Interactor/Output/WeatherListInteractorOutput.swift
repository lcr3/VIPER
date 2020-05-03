//
//  WeatherListInteractorOutput.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

protocol WeatherListInteractorOutput: AnyObject {
    func getSuccess(weather: Weather)
    func getFailure(error: Error)
}
