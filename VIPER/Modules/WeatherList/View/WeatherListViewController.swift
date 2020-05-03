//
//  WeatherListViewController.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

protocol WeatherListView: AnyObject {
    func showWeatherData(weather: Weather)
    func showErrorAletView(errorMessage: String)

    var presenter: WeatherListPresentation! { get }
}

class WeatherListViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }

    var presenter: WeatherListPresentation!
    var locations: [PinpointLocation] = []
    var forecasts: [Forcast] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationDescLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath)

        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name
        return cell
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.weatherListCellTouched(forecasts: forecasts)
    }
}

extension WeatherListViewController: WeatherListView {
    func showWeatherData(weather: Weather) {
        locationTitleLabel.text = weather.title
        locationDescLabel.text = weather.description.text
        forecasts = weather.forecasts
        locations = weather.pinpointLocations
        tableView.reloadData()
    }

    func showErrorAletView(errorMessage: String) {
        let errorAlert = UIAlertController(title: "エラー",
                                           message: errorMessage,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK",
                                           style: .default))
        present(errorAlert, animated: true)
    }
}
