//
//  RegisterViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    struct constants {
        static let cornerRadius: CGFloat = 8.0
    }

    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("register ", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImage = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImage)
       return header
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(emailField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(registerBtn)
        
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0,
                                  y: view.top,
                                  width: view.width,
                                  height: view.height/3.0
                                )
        
        emailField.frame = CGRect(x: 20,
                                  y: headerView.bottom + 30,
                                     width: view.width - 50,
                                     height: 52
                                   )
        usernameField.frame = CGRect(x: 20,
                                     y: emailField.bottom + 10,
                                     width: view.width - 50,
                                     height: 52
                                   )
        passwordField.frame = CGRect(x: 20,
                                     y: usernameField.bottom + 10,
                                     width: view.width - 50,
                                     height: 52
                                   )
        registerBtn.frame = CGRect(x: 20,
                                   y: passwordField.bottom + 30,
                                   width: view.width - 50,
                                   height: 52
                                 )
        
        configureHeaderView()
    }
    
    public func configureHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first   else{
            return
        }
        backgroundView.frame = headerView.bounds
        
        
        //Add Logo
        let imageView = UIImageView(image: UIImage(named: "instalogofull"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2,
                                 height: headerView.height - view.safeAreaInsets.top
                            )
        imageView.autoresizesSubviews = true
    }

    
    @objc private func didTapRegister(){
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, Password: password) { registered in
            DispatchQueue.main.async {
                if registered{
                    // noice
                    
                }
                else{
                    //failed
                }
            }
        }
    }
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            usernameField.becomeFirstResponder()
        }
        else if textField == usernameField{
            passwordField.becomeFirstResponder()
        }
        else{
            didTapRegister()
        }
        
        return true
    }
}
