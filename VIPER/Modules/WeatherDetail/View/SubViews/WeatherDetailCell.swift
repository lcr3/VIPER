//
//  WeatherDetailCell.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import UIKit

class WeatherDetailCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var teropLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!

    let min = "最低気温: "
    let max = "最高気温: "

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setForcast(forecast: Forcast) {
        dateLabel.text = forecast.dateLabel
        teropLabel.text = forecast.telop
        if let min = forecast.temperature.min?.celsius {
            minLabel.text = self.min + min
        } else {
            minLabel.text = self.min + "---"
        }
        if let max = forecast.temperature.max?.celsius {
            maxLabel.text = self.max + max
        } else {
            maxLabel.text = self.max + "---"
        }
    }
}
