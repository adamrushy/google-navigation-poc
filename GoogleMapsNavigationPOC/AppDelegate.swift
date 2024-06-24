//
//  AppDelegate.swift
//  GoogleMapsNavigationPOC
//
//  Created by Adam Rush on 18/06/2024.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("privateKey")
        return true
    }
}
