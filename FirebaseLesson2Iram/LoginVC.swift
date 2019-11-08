//
//  LoginVC.swift
//  FirebaseLesson2Iram
//
//  Created by C4Q on 11/7/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: UI Objects
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Post Tracker"
        label.font = UIFont(name: "Noteworthy-Bold", size: 42)
        label.textColor = UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    
    lazy var loginButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7), for: .normal)
        button.backgroundColor = UIColor(red: 129/255, green: 93/255, blue: 93/255, alpha: 1)
           button.layer.cornerRadius = 5
          // button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
           button.isEnabled = false
           return button
       }()
    
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let atttributedTitle = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        atttributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.setAttributedTitle(atttributedTitle, for: .normal)
     button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
        
    }()

    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 90/255, green: 86/255, blue: 86/255, alpha: 1)
        setupLogoLabel()
        setupStackViewForTextFieldsAndButton()
        configureDontHaveAccountButton()

        
    }
    
    
    //MARK: ObjC Handlers
    
    @objc func handleShowSignUp() {
        let signupVC = SignUpVC()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true, completion: nil)
        
    }
    
    
    @objc func formValidation() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            loginButton.backgroundColor = UIColor(red: 129/255, green: 93/255, blue: 93/255, alpha: 1)
            loginButton.isEnabled = false
            return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 129/255, green: 27/255, blue: 27/255, alpha: 1)
        
    }
    
    
    
    
    
    
   //MARK: Constraint functions
    
    private func setupLogoLabel() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoLabel)
        NSLayoutConstraint.activate([logoLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30), logoLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16), logoLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16), logoLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)])
        
        
        
    }
    
    private func setupStackViewForTextFieldsAndButton() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
    
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 130)])
        
    }
    
    private func configureDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([dontHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          dontHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          dontHaveAccountButton.heightAnchor.constraint(equalToConstant: 50)])
        
    }
    
    
    

   

}
