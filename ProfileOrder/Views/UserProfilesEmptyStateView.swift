//
//  UserProfilesEmptyStateView.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/28/21.
//

import UIKit

enum UserProfilesState {
    case empty
    case error
}

class UserProfilesEmptyStateView: UIView {
    
    let emptyStateMessage = "No new profiles to display 😕"
    let errorStateMessage = "Error retrieving profiles"
    
    var messageLabel = ProfileLabel(frame: .zero)
    
    init(state: UserProfilesState) {
        messageLabel.text = state == .empty ? emptyStateMessage : errorStateMessage
        super.init(frame: .zero)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(messageLabel)
        messageLabel.textColor = .label
        messageLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
