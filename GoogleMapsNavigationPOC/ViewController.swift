//
//  ViewController.swift
//  GoogleMapsNavigationPOC
//
//  Created by Adam Rush on 18/06/2024.
//

import UIKit
import GoogleMaps
import GoogleNavigation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var mapView: GMSMapView!
    var locationManager: CLLocationManager!
    var navigator: GMSNavigator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the camera and map settings
        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.mapType = .hybrid
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)

        // Add a button to start navigation
        let startNavigationButton = UIButton(type: .system)
        startNavigationButton.setTitle("Start Navigation", for: .normal)
        startNavigationButton.addTarget(self, action: #selector(startNavigation), for: .touchUpInside)
        startNavigationButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startNavigationButton)

        // Position the button
        NSLayoutConstraint.activate([
            startNavigationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startNavigationButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
        
        // Initialize and request location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Initialize navigator
        navigator = mapView.navigator
    }

    @objc func startNavigation() {
        
        if navigator.isGuidanceActive {
            navigator.clearDestinations()
            mapView.isNavigationEnabled = false
            return
        }
        
        GMSNavigationServices.showTermsAndConditionsDialogIfNeeded(
            withTitle: "Testing",
            companyName: "Circuit"
        ) { termsAccepted in
            if termsAccepted {
                self.mapView.navigator?.add(self)
                self.mapView.roadSnappedLocationProvider?.add(self)
                self.mapView.roadSnappedLocationProvider?.allowsBackgroundLocationUpdates = true
                self.mapView.isNavigationEnabled = true
            } else {

            }
        }

        // Initialize waypoints with location and title
        let origin = GMSNavigationWaypoint(location: CLLocationCoordinate2D(latitude: 53.715840, longitude: -1.492320), title: "Outwood")!
        let destination = GMSNavigationWaypoint(location: CLLocationCoordinate2D(latitude: 53.714890, longitude: -1.478710), title: "Sheridan Street")!

        mapView.navigator?.setDestinations([origin, destination]) { routeResult in
            self.mapView.navigator?.isGuidanceActive = true
            self.mapView.navigator?.sendsBackgroundNotifications = true
            self.mapView.roadSnappedLocationProvider?.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 10)
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}

extension ViewController: GMSRoadSnappedLocationProviderListener {
    func locationProvider(_: GMSRoadSnappedLocationProvider, didUpdate _: CLLocation) {}
}

extension ViewController: GMSNavigatorListener {
    func navigator(_ navigator: GMSNavigator, didArriveAt waypoint: GMSNavigationWaypoint) {
        print("Arrived at \(waypoint)")
    }

    func navigatorDidChangeRoute(_ navigator: GMSNavigator) {
        print("Route changed")
    }

    func navigator(_ navigator: GMSNavigator, didUpdateRemainingTime time: TimeInterval) {
        print("Remaining time: \(time)")
    }

    func navigator(_ navigator: GMSNavigator, didUpdateRemainingDistance distance: CLLocationDistance) {
        print("Remaining distance: \(distance)")
    }

    func navigator(_ navigator: GMSNavigator, didUpdate navInfo: GMSNavigationNavInfo) {
        print("Navigation info updated")
    }
}

