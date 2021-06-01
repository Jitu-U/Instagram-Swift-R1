//
//  LoginViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//


import FirebaseAuth
import SafariServices
import UIKit

class LoginViewController: UIViewController {

    struct constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let emailUserNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "username or email"
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
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = constants.cornerRadius
        button.backgroundColor = .systemBlue
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
    
    private let privacyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let aboutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("About us", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("New here? \n  create account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    
    //Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.addTarget(self,
                           action: #selector(didTapLoginBtn),
                           for: .touchUpInside)
        
        registerBtn.addTarget(self,
                           action: #selector(didTapRegisterBtn),
                           for: .touchUpInside)
        
        privacyBtn.addTarget(self,
                           action: #selector(didTapPrivacyBtn),
                           for: .touchUpInside)
        
        aboutBtn.addTarget(self,
                           action: #selector(didTapAboutBtn),
                           for: .touchUpInside)
        
        emailUserNameField.delegate = self
        passwordField.delegate = self
        
        
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Assign Frames
        
        
        headerView.frame = CGRect(x: 0,
                                  y: view.top,
                                  width: view.width,
                                  height: view.height/3.0
                                )
        
        emailUserNameField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 30,
                                          width: view.width - 50,
                                          height: 52
                                )
        
        passwordField.frame = CGRect(    x: 25,
                                         y: emailUserNameField.bottom + 10,
                                      width: view.width - 50,
                                      height: 52
                                )
        
        loginBtn.frame = CGRect(x: 25,
                                y: passwordField.bottom+10 ,
                                  width: view.width - 50,
                                  height: 52
                                )
        
        registerBtn.frame = CGRect(x: 25,
                                y: loginBtn.bottom+10 ,
                                  width: view.width - 50,
                                  height: 52
                                )
        
        privacyBtn.frame = CGRect(x: 120,
                                  y: view.bottom - 100,
                                  width: registerBtn.width/2,
                                  height: 20)
        
        aboutBtn.frame = CGRect(x: 120,
                                  y: privacyBtn.bottom + 10,
                                  width: registerBtn.width/2,
                                  height: 20)
        
        
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
    
    private func addSubviews(){
        view.addSubview(headerView)
        view.addSubview(emailUserNameField)
        view.addSubview(passwordField)
        view.addSubview(loginBtn)
        view.addSubview(privacyBtn)
        view.addSubview(aboutBtn)
        view.addSubview(registerBtn)
        
    }

    
    @objc private func didTapLoginBtn(){
        emailUserNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard  let usernameEmail = emailUserNameField.text, !usernameEmail.isEmpty,
               let password = passwordField.text, !password.isEmpty, password.count >= 8 else{
                return
               }
        
        
        
        //Login Functionality
        
        var username : String?
        var email : String?
        
        if  usernameEmail.contains("@"), usernameEmail.contains(".") {
            //email
            email = usernameEmail
        }
        else{
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password){
            success in
            
            DispatchQueue.main.async {
                if success {
                    //user Login
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    //error
                    let alert = UIAlertController(title: "Error",
                                                  message: "wrong credentials \n Try again ",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
        
        
    }
    
    @objc private func didTapPrivacyBtn(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapAboutBtn(){
        guard let url = URL(string: "https://about.instagram.com") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapRegisterBtn(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    
    

}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailUserNameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLoginBtn()
        }
        return true
    }
}
