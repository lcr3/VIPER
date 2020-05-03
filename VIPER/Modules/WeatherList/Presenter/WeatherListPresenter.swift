//
//  WeatherListPresenter.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

protocol WeatherListPresentation {
    func viewDidLoad()
    func weatherListCellTouched(forecasts: [Forcast])
}

class WeatherListPresenter {
    private weak var view: WeatherListView?
    private let router: WeatherListWireframe
    private let interactor: WeatherListUsecase

    init(view: WeatherListView,
         interactor: WeatherListUsecase,
         router: WeatherListWireframe) {

        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WeatherListPresenter: WeatherListPresentation {
    func viewDidLoad() {
        interactor.getLocations()
    }

    func weatherListCellTouched(forecasts: [Forcast]) {
        router.showWeatherDetail(forecasts: forecasts)
    }
}

extension WeatherListPresenter: WeatherListInteractorOutput {
    func getSuccess(weather: Weather) {
        view?.showWeatherData(weather: weather)
    }

    func getFailure(error: Error) {
        view?.showErrorAletView(errorMessage: "取得に失敗しました。")
    }
}
