//
//  AuthViewController.swift
//  Dance Journal
//
//  Created by João Pedro Picolo on 08/10/21.
//

import UIKit
import SnapKit
import LocalAuthentication

class AuthViewController: UIViewController {
    /// An authentication context stored at class scope so it's available for use during UI updates.
    var context = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The biometryType, which affects this app's UI when state changes, is only meaningful
        //  after running canEvaluatePolicy
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "appBackground")
        setTitle()
        setLoginButton()
    }
    
    private func setTitle() {
        let titleView = UIView()
        view.addSubview(titleView)
        titleView.snp.makeConstraints { make -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 200, left: 18, bottom: 450, right: 18))
        }

        let title = UILabel()
        title.text = "Dance Journal"
        title.textColor = UIColor(named: "fontColor")
        title.font = UIFont(name: "Kreon-Bold", size: 54)
        titleView.addSubview(title)
        title.snp.makeConstraints { make -> Void in
            make.edges.equalTo(titleView).inset(UIEdgeInsets(top: 20, left: 15, bottom: 100, right: 15))
        }
        
        let subtitle = UILabel()
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        subtitle.textColor = UIColor(named: "fontColor")
        subtitle.text = "Transform your thoughts into movement"
        subtitle.font = UIFont(name: "KulimPark-SemiBoldItalic", size: 22)
        titleView.addSubview(subtitle)
        subtitle.snp.makeConstraints { make -> Void in
            make.edges.equalTo(titleView).inset(UIEdgeInsets(top: 50, left: 30, bottom: 0, right: 30))
        }
    }
    
    private func setLoginButton() {
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = UIColor(named: "loginBackgroundColor")
        
        loginButton.tintColor = .white
        loginButton.setImage(UIImage(systemName: "applelogo"), for: .normal)
        
        loginButton.setTitle("  Continue with Apple", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        loginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 580, left: 15, bottom: 200, right: 15))
        }
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        // Get a fresh context for each login. If you use the same context on multiple attempts
        //  (by commenting out the next line), then a previously successful authentication
        //  causes the next policy evaluation to succeed without testing biometry again.
        //  That's usually not what you want.
        context = LAContext()

        context.localizedCancelTitle = "Enter Username/Password"

        // First check if we have the needed hardware support.
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                if success {
                    DispatchQueue.main.async { [unowned self] in
                        let tabBarController = TabBarViewController()
                        navigationController?.setViewControllers([tabBarController], animated: true)
                    }

                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                    // Fall back to a asking for username and password.
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            // Fall back to a asking for username and password.
        }
    }
}
