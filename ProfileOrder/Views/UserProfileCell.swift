//
//  UserProfileCell.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import UIKit

class UserProfileCell: UITableViewCell {
    
    static var reuseID = "UserProfileCell"
    
    lazy var sectionTitleLabel: ProfileLabel = {
        return ProfileLabel(frame: .zero)
    }()
    
    lazy var sectionContentLabel: ProfileLabel = {
        return ProfileLabel(frame: .zero)
    }()
    
    lazy var profileImageView: ProfileImageView = {
        return ProfileImageView(frame: .zero)
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
        Configures cell based on the profile field 
     */
    func configure(profileField: ProfileField, fieldContent: String) {
        switch profileField {
        case .name:
            configureNameCell(with: fieldContent)
        case .photo:
            configureImageCell(with: fieldContent)
        default:
            configureGenericCell(sectionTitle: profileField.sectionTitle(), sectionContent: fieldContent)
        }
    }
    
    private func configureNameCell(with name: String) {
        contentView.addSubview(sectionTitleLabel)
        sectionTitleLabel.configure(text: name, font: .systemFont(ofSize: 28, weight: .bold))
        
        NSLayoutConstraint.activate([
            sectionTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            sectionTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12)
        ])
    }
    
    private func configureImageCell(with image: String) {
        profileImageView.displayImageFromUrl(from: image)
        contentView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureGenericCell(sectionTitle: String, sectionContent: String) {
        let stackView = UIStackView(arrangedSubviews: [sectionTitleLabel,
                                                      sectionContentLabel])
        sectionTitleLabel.configure(text: sectionTitle, font: .systemFont(ofSize: 24, weight: .bold))
        sectionContentLabel.configure(text: sectionContent)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
        ])
    }
    
    override func prepareForReuse() {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}
