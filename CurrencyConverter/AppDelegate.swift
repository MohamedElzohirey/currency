//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let codeChallange = CodeChallange()
        /*
         Add arithmetic operators (add, subtract, multiply, divide) to make the following expressions true. You can use any parentheses you’d like.
        3 1 3 9 = 12
        ((3+1)/3)*9
        */
        /*
         anagrams
         */
        codeChallange.checkAnagrams(first: "debit card", second: "bad credit")
        codeChallange.checkAnagrams(first: "punishments", second: "ninethumps")
        print(codeChallange.fibonacciRecursion(n: 10))
        print(codeChallange.fibonacciIteration(n: 10))
        /*
            Which architecture would you use for the required task
         */
        /*
         I would use MVC for simplicty as long as there are no much need for code resuability or massive vc
         But I used MVVM as required
         */
        
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

