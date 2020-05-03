//
//  WeatherListInteractor.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

protocol WeatherListUsecase {
    var output: WeatherListInteractorOutput? { get }

    func getLocations()
}

class WeatherListInteractor {
    private let client: APIRequestable

    weak var output: WeatherListInteractorOutput?

    init(client: APIRequestable = APIClient()) {
        self.client = client
    }
}

extension WeatherListInteractor: WeatherListUsecase {
    func getLocations() {
        let url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=400040"
        let request = AbstractRequest<Weather>(urlString: url, method: .get, parameters: nil)
        client.request(request: request) { result in
            switch result {
            case .success:
                do {
                    let weather = try result.get()
                    self.output?.getSuccess(weather: weather)
                } catch {
                    self.output?.getFailure(error: APIError.responseParseError)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.output?.getFailure(error: error)
            }
        }
    }
}
