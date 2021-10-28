//
//  ProfileLabel.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import UIKit

class ProfileLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String? = "", font: UIFont? = .systemFont(ofSize: 20, weight: .regular)) {
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        textColor = .label
    }
}
