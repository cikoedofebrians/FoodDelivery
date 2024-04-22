//
//  LoginLandingViewController.swift
//  FoodDelivery
//
//  Created by Ciko Edo Febrian on 15/04/24.
//

import UIKit

class LoginLandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


//MARK: - UIViewController
extension UIViewController {
    func showLoginLandingViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginLanding") as! LoginLandingViewController
        let window = UIApplication.shared.windows.first!
        window.rootViewController = viewController
    }
}
