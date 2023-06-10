//
//  WeatherViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.05.2023.
//

import UIKit

struct WeatherViewModel {
    let type: WeatherType
    let placeName: String
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    let description: String
    
    var temperatureString: String {
        return String(format: "%.0f\(Resources.Strings.degreeSymbol)C", temperature)
    }
    
    var temperatureRange: String {
        let tempMinStr = String(format: "%.0f\(Resources.Strings.degreeSymbol)C", tempMin)
        let tempMaxStr = String(format: "%.0f\(Resources.Strings.degreeSymbol)C", tempMax)
        return "H: \(tempMaxStr) L: \(tempMinStr)"
    }
    
    var weatherImage: UIImage? {
        switch type {
        case .storm:
            return Resources.Images.Weather.storm
        case .partyRain:
            return Resources.Images.Weather.partyRain
        case .rainfall:
            return Resources.Images.Weather.rainfall
        case .rain:
            return Resources.Images.Weather.rain
        case .snow:
            return Resources.Images.Weather.snow
        case .windy:
            return Resources.Images.Weather.windy
        case .sun:
            return Resources.Images.Weather.sun
        case .partyCloudy:
            return Resources.Images.Weather.partyCloudy
        case .clouds:
            return Resources.Images.Weather.clouds
        }
    }
}
