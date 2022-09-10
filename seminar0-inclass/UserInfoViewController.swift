//
//  UserInfoViewController.swift
//  seminar0-inclass
//
//  Created by 이선재 on 2022/09/10.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var usernameText: String?
    var emailText: String?
    
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
        titleLabel.text = "유저 정보"
        titleLabel.font = .systemFont(ofSize: fontSize)
        
        let usernameLabel = UILabel()
        usernameLabel.text = "유저 이름"
        usernameLabel.font = .systemFont(ofSize: fontSize)
        usernameLabel.textColor = UIColor.gray
        
        let emailLabel = UILabel()
        emailLabel.text = "이메일"
        emailLabel.font = .systemFont(ofSize: fontSize)
        emailLabel.textColor = UIColor.gray
        
        let username = UILabel()
        username.text = usernameText
        username.font = .systemFont(ofSize: fontSize)
        
        let email = UILabel()
        email.text = emailText
        email.font = .systemFont(ofSize: fontSize)
        
        // Button
        let logoutButton = UIButton()
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.backgroundColor = .gray
        logoutButton.layer.cornerRadius = 5
        logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
    
        // Add Subviews
        self.view.addSubview(titleLabel)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(emailLabel)
        
        self.view.addSubview(username)
        self.view.addSubview(email)
        
        self.view.addSubview(logoutButton)
    
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        username.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Labels
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            usernameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leadingTrailingConstraint),
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leadingTrailingConstraint),
            
            // TextFields
            username.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            username.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -leadingTrailingConstraint),
            username.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            
            email.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            email.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -leadingTrailingConstraint),
            email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            
            // Button
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 50),
            logoutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -250)
        ])
    }
    
    @objc func tapLogoutButton() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
