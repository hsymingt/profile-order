//
//  UserProfileProvider.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import UIKit

class UserProfileProvider: NSObject {
    var viewModel: UserProfileViewModel!
}

extension UserProfileProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.fieldsDisplayOrder.count ?? 0
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = viewModel.fieldsDisplayOrder[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileCell.reuseID) as? UserProfileCell else {
            return UserProfileCell()
        }
        cell.configure(profileField: field.0, fieldContent: field.1)
        return cell
    }
}

extension UserProfileProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightForField = viewModel.fieldsDisplayOrder[indexPath.row].0.estimatedCellHeight()
        return CGFloat(heightForField)
    }
}
