//
//  LoginVC.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 11/07/2021.
//

import UIKit
import RxCocoa
import RxSwift

class LoginVC: UIViewController {
    
    let emailTextField    = GFTextField(placeholder: "enter your email")
    let passwordTextField = GFTextField(placeholder: "enter your password")
    let loginButton       = GFButton(color: .orange, title: "Login")
    let loginViewModel    = LoginViewModel()
    let disposeBag        = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureStackView()
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeIsLoginEnabled()
        subscribeToLoginButton()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Login"
    }
    
    func configureStackView() {
        let stackView          = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        stackView.axis         = .vertical
        stackView.spacing      = 10
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func bindTextFieldsToViewModel() {
        emailTextField.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        loginViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showProgressIndicator()
            } else {
                self.dismissIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    func subscribeToResponse() {
        loginViewModel.loginModelObservable.subscribe(onNext: {
            let vc = HomeVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            print($0.token)
        }).disposed(by: disposeBag)
    }
    
    func subscribeIsLoginEnabled() {
        loginViewModel.isLoginButtonEnapled.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func subscribeToLoginButton() {
        loginButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.loginViewModel.getData()
            }).disposed(by: disposeBag)
    }
}
