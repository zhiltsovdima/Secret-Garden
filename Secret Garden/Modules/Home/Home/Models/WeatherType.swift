//
//  WeatherType.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.06.2023.
//

import Foundation

enum WeatherType {
    case storm
    case partyRain
    case rainfall
    case rain
    case snow
    case windy
    case sun
    case partyCloudy
    case clouds
    
    init(weatherId: Int) {
        switch weatherId {
        case 200...232:
            self = .storm
        case 300...321:
            self = .partyRain
        case 500...502:
            self = .partyRain
        case 503, 504, 521...531:
            self = .rainfall
        case 514...520:
            self = .rain
        case 600...622:
            self = .snow
        case 701...781:
            self = .windy
        case 800:
            self = .sun
        case 801:
            self = .partyCloudy
        case 802...804:
            self = .clouds
        default:
            self = .clouds
        }
    }
}
