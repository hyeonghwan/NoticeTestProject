//
//  AppDelegate.swift
//  NoticeTestProject
//
//  Created by 박형환 on 2022/03/09.
//

import UIKit
import Firebase
import FirebaseRemoteConfig
import FirebaseAnalytics
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var remoteConfig: RemoteConfig!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        remoteConfig = RemoteConfig.remoteConfig()
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig?.configSettings = setting
        
        Installations.installations().authTokenForcingRefresh(true, completion: { (result, error) in
          if let error = error {
            print("Error fetching token: \(error)")
            return
          }
          guard let result = result else { return }
          print("Installation auth token: \(result.authToken)")
        })
       
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

