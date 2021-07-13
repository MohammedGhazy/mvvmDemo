//
//  HomeVC.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 12/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
class HomeVC: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let homeViewModel = HomeViewModel()
    let disposeBag    = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToPostSelection()
        getData()
    }
    
    func configureViewController() {
        title = "Home"
        view.backgroundColor = .systemBackground
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func subscribeToLoading() {
        homeViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showProgressIndicator()
            } else {
                self.dismissIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    func subscribeToResponse() {
        self.homeViewModel.homeModelObservable
            .bind(to: self.tableView
                    .rx
                    .items(cellIdentifier: HomeTableViewCell.reuseIdentifier,
                           cellType: HomeTableViewCell.self)) { row, home, cell in
                print(row)
                cell.titleLabel.text     = home.title
                cell.secondaryLabel.text = home.body
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeToPostSelection() {
        Observable.zip(tableView.rx.itemSelected,tableView.rx.modelSelected(HomeModel.self)).bind(onNext: {
            selectedIndex,post in
            print(selectedIndex)
        }).disposed(by: disposeBag)
    }
    
    func getData() {
        homeViewModel.getData()
    }
    
}
