//
//  HomeTableViewCell.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 12/07/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "HomeTableViewCell"
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.lineBreakMode             = .byTruncatingTail
        titleLabel.textColor                 = .red
        titleLabel.minimumScaleFactor        = 0.9
        titleLabel.textAlignment             = .left
        titleLabel.font                      = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let secondaryLabel: UILabel = {
        let secondaryLabel = UILabel()
        secondaryLabel.adjustsFontSizeToFitWidth = true
        secondaryLabel.lineBreakMode             = .byTruncatingTail
        secondaryLabel.textColor                 = .label
        secondaryLabel.minimumScaleFactor        = 0.9
        secondaryLabel.numberOfLines             = 3
        secondaryLabel.textAlignment             = .left
        secondaryLabel.font                      = UIFont.systemFont(ofSize: 12, weight: .bold)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        return secondaryLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(titleLabel)
        addSubview(secondaryLabel)
        let padding:CGFloat = 4
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            secondaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: padding),
            secondaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            secondaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding),
            secondaryLabel.heightAnchor.constraint(equalToConstant: 14),
        ])
    }
    
}
