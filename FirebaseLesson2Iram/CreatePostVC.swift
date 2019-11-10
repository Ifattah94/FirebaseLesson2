//
//  CreatePostVC.swift
//  FirebaseLesson2Iram
//
//  Created by C4Q on 11/9/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class CreatePostVC: UIViewController {

    
    
    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 2
        tf.placeholder = "Title"
        return tf
    }()
    
    lazy var bodyTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = true
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.borderWidth = 2
        return tv
    }()
    
    lazy var postButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.isEnabled = false
        button.backgroundColor = .gray
        button.setTitle("Post", for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitleTextField()
        setupBodyTextView()
        setupPostButton()

        // Do any additional setup after loading the view.
    }
    

    //MARK: Constraint functions
    
    private func setupTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleTextField.heightAnchor.constraint(equalToConstant: 40)])
        
    }
    
    private func setupBodyTextView() {
        view.addSubview(bodyTextView)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bodyTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
                                     bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     bodyTextView.heightAnchor.constraint(equalToConstant: 180)])
    }
    
    
    private func setupPostButton() {
        view.addSubview(postButton)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([postButton.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 16),
                                     postButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     postButton.heightAnchor.constraint(lessThanOrEqualToConstant: 50)])
    }
  

}
