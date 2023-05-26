//
//  WeatherModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.05.2023.
//

import UIKit

struct WeatherModel {
    let weatherId: Int
    let placeName: String
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    let description: String
    
    var temperatureString: String {
        return String(format: "%.0f\(Resources.Strings.degreeSymbol)C", temperature)
    }
    
    var tempMinMaxString: String {
        let tempMinStr = String(format: "%.0f\(Resources.Strings.degreeSymbol)C", tempMin)
        let tempMaxStr = String(format: "%.0f\(Resources.Strings.degreeSymbol)C", tempMax)
        return "H: \(tempMaxStr) L: \(tempMinStr)"
    }
    
    var weatherImage: UIImage? {
        switch weatherId {
        case 200...232:
            return Resources.Images.Weather.storm
        case 300...321:
            return Resources.Images.Weather.partyRain
        case 500...502:
            return Resources.Images.Weather.partyRain
        case 503, 504, 521...531:
            return Resources.Images.Weather.rainfall
        case 514...520:
            return Resources.Images.Weather.rain
        case 600...622:
            return Resources.Images.Weather.snow
        case 701...781:
            return Resources.Images.Weather.windy
        case 800:
            return Resources.Images.Weather.sun
        case 801:
            return Resources.Images.Weather.partyCloudy
        case 802...804:
            return Resources.Images.Weather.clouds
        default:
            return Resources.Images.Weather.clouds
        }
    }
}
