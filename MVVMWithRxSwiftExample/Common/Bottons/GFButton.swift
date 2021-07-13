//
//  GFButton.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 11/07/2021.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: UIColor , title: String) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        configureBtn()
    }
    
    private func configureBtn(){
        layer.cornerRadius = 14
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor , with title: String){
        self.backgroundColor  = backgroundColor
        self.setTitle(title, for: .normal)
    }
}
