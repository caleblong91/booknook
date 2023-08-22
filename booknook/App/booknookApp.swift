//
//  booknookApp.swift
//  booknook
//
//  Created by Caleb Long on 8/3/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    
}

class ThisAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    if #available(iOS 14.0, *) {
      return AppAttestProvider(app: app)
    } else {
      return DeviceCheckProvider(app: app)
    }

  }
}

@main
struct booknookApp: App {
    //init(){
    //   let providerFactory = ThisAppCheckProviderFactory()
    //   AppCheck.setAppCheckProviderFactory(providerFactory)
        
    //}
    @StateObject var viewModelAuth = authViewModel()
    @StateObject var viewModelApp = appViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
     
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModelAuth)
                .environmentObject(viewModelApp)
                .task {
                    await viewModelApp.requestDataScannerAccessStatus()
                }
        }
    }
}
