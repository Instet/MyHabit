//
//  AppDelegate.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 14.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        // MARK: настройка светлой темы для всего приложения
        self.window?.overrideUserInterfaceStyle = .light

        let tabBarController = UITabBarController()

        let habitsVC = HabitsViewController()
        let habitsNavigationController = UINavigationController(rootViewController: habitsVC)
        
        let infoVC = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoVC)

        habitsNavigationController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), selectedImage: nil)

        infoNavigationController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), selectedImage: nil)

        // MARK: Color tabBar icons
        UITabBar.appearance().tintColor = ColorSet.colorPurple

        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()

        return true
    }


}

