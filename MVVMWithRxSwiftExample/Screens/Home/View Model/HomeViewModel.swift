//
//  HomeViewModel.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 12/07/2021.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift
class HomeViewModel {
    
    var loadingBehavior          = BehaviorRelay<Bool>(value: false)
    private var isTableHidden    = BehaviorRelay<Bool>(value: false)
    private var homeModelSubject = PublishSubject<[HomeModel]>()
    
    var homeModelObservable: Observable<[HomeModel]> {
        return homeModelSubject
    }
    
    var isTableHiddenObservable:Observable<Bool> {
        return isTableHidden.asObservable()
    }
    
    func getData() {
        loadingBehavior.accept(true)
        let url     = "https://jsonplaceholder.typicode.com/posts"
        
        APIServices.instance.getData(url: url, method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) { [weak self] (homeModel: [HomeModel]?, baseError: LoginFailureModel?, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
            } else if let baseError = baseError {
                print(baseError.message ?? "")
            } else {
                guard let homeModel = homeModel else { return }
                if homeModel.count > 0 {
                    self.homeModelSubject.onNext(homeModel)
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
                
            }
        }
    }
}
