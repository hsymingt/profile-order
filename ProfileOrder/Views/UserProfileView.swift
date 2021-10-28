//
//  UserProfileView.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/28/21.
//

import UIKit

class UserProfileView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        allowsSelection = false
    }
}
