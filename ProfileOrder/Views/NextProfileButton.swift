//
//  NextProfileButton.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import UIKit

class NextProfileButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(.label, for: .normal)
        setTitle("Next", for: .normal)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 37.5
        clipsToBounds = true
    }
}
