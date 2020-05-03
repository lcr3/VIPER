//
//  WeatherDetailViewController.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

protocol WeatherDetailView: AnyObject {
    var forecasts: [Forcast] { get set }
}

class WeatherDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }

    var presenter: WeatherDetailPresentation!
    var forecasts: [Forcast] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailCell") as? WeatherDetailCell else {
            return UITableViewCell()
        }
        let forcast = forecasts[indexPath.row]
        cell.setForcast(forecast: forcast)
        return cell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {

}

extension WeatherDetailViewController: WeatherDetailView {

}
