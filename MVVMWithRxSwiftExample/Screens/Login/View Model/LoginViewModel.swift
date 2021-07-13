//
//  LoginViewModel.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 11/07/2021.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class LoginViewModel {
    
    var emailBehavior    = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var loginModelSubject = PublishSubject<LoginSuccessModel>()
    
    var loginModelObservable: Observable<LoginSuccessModel> {
        return loginModelSubject
    }
    
    var isValidEmail: Observable<Bool> {
        return emailBehavior.asObservable().map { (email) in
            let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            
            return isEmailEmpty
        }
    }
    
    var isValidPassword: Observable<Bool> {
        return passwordBehavior.asObservable().map { (password) in
            let isPasswordEmpty = password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            
            return isPasswordEmpty
        }
    }
    
    var isLoginButtonEnapled: Observable<Bool> {
        return Observable.combineLatest(isValidEmail, isValidPassword) { (isEmailEmpty, isPasswordEmpty) in
            let loginValid = !isEmailEmpty && !isPasswordEmpty
            return loginValid
        }
    }
    
    
    func getData() {
        loadingBehavior.accept(true)
        let url     = "https://unmutes.herokuapp.com/auth/login"
        let params  = [
            "email": emailBehavior.value,
            "password": passwordBehavior.value,
        ]
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        APIServices.instance.getData(url: url, method: .post, params: params, encoding: JSONEncoding.default, headers: headers) {[weak self] (loginSuccessModel:LoginSuccessModel?, baseError:LoginFailureModel?, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
            } else if let baseError = baseError {
                print(baseError.message ?? "")
            } else {
                guard let loginSuccessModel = loginSuccessModel else { return }
                self.loginModelSubject.onNext(loginSuccessModel)
            }
            
        }
    }
    
}
