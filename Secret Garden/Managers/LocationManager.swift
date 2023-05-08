//
//  LocationManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.05.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    weak var delegate: WeatherManagerDelegate?
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func getPlace(from location: CLLocation, completion: @escaping (String) -> Void) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                completion("Unknown")
                return
            }
            let place = placemark.locality ?? "Unknown"
            completion(place)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        getPlace(from: currentLocation) { [weak self] place in
            let latitude = String(currentLocation.coordinate.latitude)
            let longitude = String(currentLocation.coordinate.longitude)
            self?.locationManager.stopUpdatingLocation()
            self?.delegate?.didUpdateLocation(place: place, latitude: latitude, longitude: longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}
