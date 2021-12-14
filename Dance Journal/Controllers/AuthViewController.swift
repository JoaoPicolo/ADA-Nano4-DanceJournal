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
    // Components
    lazy private var appName: UIStackView = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .center
        title.text = "Dance Journal"
        title.textColor = UIColor(named: "fontColor")
        title.font = UIFont(name: "Kreon-Bold", size: 54)
        
        let subtitle = UILabel()
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        subtitle.textColor = UIColor(named: "fontColor")
        subtitle.text = "Transform your thoughts into movement"
        subtitle.font = UIFont(name: "KulimPark-SemiBoldItalic", size: 22)

        let titleView = UIStackView(arrangedSubviews: [title, subtitle])
        titleView.axis = .vertical
        titleView.spacing = 10
        
        return titleView
    }()
    
    lazy private var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = UIColor(named: "loginBackgroundColor")
        
        loginButton.tintColor = .white
        loginButton.setImage(UIImage(systemName: "applelogo"), for: .normal)
        
        loginButton.setTitle("  Continue with Apple", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        loginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        return loginButton
    }()
    
    /// An authentication context stored at class scope so it's available for use during UI updates.
    var context = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The biometryType, which affects this app's UI when state changes, is only meaningful
        //  after running canEvaluatePolicy
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
        setupHierarchy()
        setupConstraints()
    }

    private func setupHierarchy() {
        view.backgroundColor = UIColor(named: "appBackground")
        
        view.addSubview(appName)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        appName.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(180)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
            make.height.equalTo(50)
            make.bottom.equalTo(-140)
        }
    }

    
    @objc func handleAuthorizationAppleIDButtonPress() {
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
