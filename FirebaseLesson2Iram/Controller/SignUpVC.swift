//
//  SignUpVC.swift
//  FirebaseLesson2Iram
//
//  Created by C4Q on 11/8/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {

    //MARK: UI Objects
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    lazy var userNameTextField: UITextField = {
        let tf = UITextField()
         tf.placeholder = "UserName"
         tf.backgroundColor = UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7)
         tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 14)
         tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
         return tf
    }()
    
    
    lazy var fullNameTextField: UITextField = {
        let tf = UITextField()
         tf.placeholder = "Full Name"
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
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
     button.setTitleColor(UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7), for: .normal)
     button.backgroundColor = UIColor(red: 129/255, green: 93/255, blue: 93/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignupPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let atttributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        atttributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.setAttributedTitle(atttributedTitle, for: .normal)
        
      button.addTarget(self, action: #selector(handleShowLogin), for:.touchUpInside )
        return button
    }()
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 90/255, green: 86/255, blue: 86/255, alpha: 1)
        configureStackViewsForTextFieldsAndButtons()
        configureAlreadyHaveAccountButton()
    }
    
    
    //MARK: Objc Handlers
    
    @objc func handleShowLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func formValidation() {
        guard emailTextField.hasText, passwordTextField.hasText, fullNameTextField.hasText, userNameTextField.hasText else {
            signUpButton.backgroundColor = UIColor(red: 129/255, green: 93/255, blue: 93/255, alpha: 1)
            signUpButton.isEnabled = false
            return
        }
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 129/255, green: 27/255, blue: 27/255, alpha: 1)
        
    }
    
    
    @objc func handleSignupPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(withTitle: "Error", andMessage: "Failed to create account")
            print("Failed to sign up")
            return
        }
        
        
        FirebaseAuthService.manager.createNewUser(withEmail: email, password: password) { [weak self] (result) in
            
            self?.handleCreateAccountResponse(with: result)
            
        }
        
        
    }
    
    //MARK: Private methods
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async {
            
        
        switch result {
        case .success(let user):
            
            FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                FirebaseAuthService.manager.updateUserName(userName: self?.userNameTextField.text ?? "NA")
                self?.handleCreatedUserInFirestore(result: newResult)
            }
            
        case .failure(let error):
            self.showAlert(withTitle: "Error creating user", andMessage: "an error occured while creating new account \(error)")
        }
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<Void, Error>) {
        switch result {
        case .success:
            let mainTabVC = MainTabVC()
            mainTabVC.modalPresentationStyle = .fullScreen
            present(mainTabVC, animated: true, completion: nil)
            
        case .failure(let error):
            print("error adding user to firestore \(error)")
        }
    }
    
    
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    




    
    
    
    //MARK: Constraint functions
    private func configureStackViewsForTextFieldsAndButtons() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, fullNameTextField, passwordTextField, signUpButton])
        
        stackView.axis = .vertical
         stackView.spacing = 10
         stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        stackView.heightAnchor.constraint(equalToConstant: 240)])
        
    }
    
    
    private func configureAlreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([alreadyHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     alreadyHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor), alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    

  

}
