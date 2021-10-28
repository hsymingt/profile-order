//
//  ProfileImageView.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import UIKit

class ProfileImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "placeholder-image")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
    }
    
    /*
        Loads image view with image from url
        On failure, displays a placeholder image instead
     */
    func displayImageFromUrl(from urlString: String) {
        image = nil
        
        guard let url = URL(string: urlString) else {
            image = placeholderImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.image = self.placeholderImage
                }
            }
        }
    }
}
