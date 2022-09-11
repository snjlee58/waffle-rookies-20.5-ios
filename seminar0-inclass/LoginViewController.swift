//
//  ViewController.swift
//  seminar0-inclass
//
//  Created by 한상현 on 2022/09/06.
//

import UIKit

class LoginViewController: UIViewController {
    
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        
        self.view.backgroundColor = .white
        let leadingTrailingConstraint: CGFloat = 25
        let fontSize: CGFloat = 17
        
        
        // Labels
        let titleLabel = UILabel()
        titleLabel.text = "로그인"
        titleLabel.font = .systemFont(ofSize: fontSize)
        
        let usernameLabel = UILabel()
        usernameLabel.text = "유저 이름"
        usernameLabel.font = .systemFont(ofSize: fontSize)
        usernameLabel.textColor = UIColor.gray
        
        let emailLabel = UILabel()
        emailLabel.text = "이메일"
        emailLabel.font = .systemFont(ofSize: fontSize)
        emailLabel.textColor = UIColor.gray
        
        let passwordLabel = UILabel()
        passwordLabel.text = "비밀번호"
        passwordLabel.font = .systemFont(ofSize: fontSize)
        passwordLabel.textColor = UIColor.gray
        
        // TextFields
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "두 글자 이상"
        
        emailTextField.borderStyle = .roundedRect
        
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        // Button
        let loginButton = UIButton()
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        
        
        // Add Subviews
        self.view.addSubview(titleLabel)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(passwordLabel)
        
        self.view.addSubview(usernameTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        
        self.view.addSubview(loginButton)
        
        // Autolayout Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Labels
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            usernameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leadingTrailingConstraint),
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leadingTrailingConstraint),

            passwordLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leadingTrailingConstraint),
            
            // TextFields
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -leadingTrailingConstraint),
            usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            
            emailTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -leadingTrailingConstraint),
            emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            
            passwordTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -leadingTrailingConstraint),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            
            // Button
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 50),
            loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -250)
        ])
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func tapLoginButton() {
        if usernameTextField.text!.count < 2 {
            let alert = UIAlertController(title: "Alert", message: "username은 두 글자 이상이어야 합니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: { return })
        }
        
        let nextVC = UserInfoViewController()
        nextVC.usernameText = usernameTextField.text
        nextVC.emailText = emailTextField.text
        navigationController?.pushViewController(nextVC, animated: true)
    }
    

}
