//
//  GFTextField.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 11/07/2021.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMyTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String ) {
        super.init(frame: .zero)
        self.placeholder        = placeholder
        configureMyTextField()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    private func configureMyTextField(){
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 14
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.white.cgColor
        
        textColor                                   = .label
        tintColor                                   = .label
        
        backgroundColor                             = .tertiarySystemBackground
        
        textAlignment                               = .left
        returnKeyType                               = .default
        
        adjustsFontSizeToFitWidth                   = true
        minimumFontSize                             = 12
        autocorrectionType                          = .no
        
        layer.shadowOpacity = 2
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.systemGray4.cgColor
        
        font = UIFont.preferredFont(forTextStyle: .title2)
    }
}
