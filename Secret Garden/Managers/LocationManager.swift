//
//  LocationManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.05.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    let locationManager = CLLocationManager()
    
    var delegate: WeatherManagerDelegate?
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let latitude = String(currentLocation.coordinate.latitude)
        let longitude = String(currentLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        delegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}
