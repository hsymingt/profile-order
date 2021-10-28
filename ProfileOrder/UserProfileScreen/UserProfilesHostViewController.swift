//
//  UserProfilesHostViewController.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import Combine
import UIKit

class UserProfilesHostViewController: UIViewController {

    var dataManager = ProfileOrderDataManager()
    var provider = UserProfileProvider()
    
    var loadingIndicator = UIActivityIndicatorView(style: .large)
    var profileView = UserProfileView()
    var nextButton = NextProfileButton()
    
    var viewModels: [UserProfileViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureProfileView()
        configureNextButton()
        configureLoadingView()
        getProfileOrder()
    }
    
    /*
        Fetch user profiles and expected profile configuration
     */
    func getProfileOrder() {
        showLoadingActivity(true)
        
        dataManager.getProfilesAndConfig { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let (users, config)):
                self.onGetProfileDataSuccess(users: users, config: config)
            case .failure(_):
                self.onGetProfileDataError()
            }
        }
    }
    
    /*
        Map users into list of view models
     */
    func onGetProfileDataSuccess(users: [User], config: [ProfileField]) {
        showLoadingActivity(false)
        if users.isEmpty {
            displayEmptyView(state: .empty)
            return
        }
        
        viewModels = users.map { UserProfileViewModel(from: $0, with: config) }
        displayNextProfile()
    }
    
    /*
        Show error state
     */
    func onGetProfileDataError() {
        displayEmptyView(state: .error)
    }
    
    @objc
    func nextButtonPressed() {
        displayNextProfile()
    }
    
    /*
        Display the next user profile from the list of view models or the empty state view
     */
    func displayNextProfile() {
        if viewModels.isEmpty {
            displayEmptyView(state: .empty)
        } else {
            provider.viewModel = viewModels.removeFirst()
            DispatchQueue.main.async {
                self.profileView.reloadData()
            }
        }
    }
    
    func showLoadingActivity(_ contentLoading: Bool) {
        DispatchQueue.main.async {
            contentLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
        }
    }
    
    func configureLoadingView() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator.hidesWhenStopped = true
    }
    
    func configureNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 75),
            nextButton.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    func configureProfileView() {
        view.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
        
        profileView.dataSource = provider
        profileView.delegate = provider
        profileView.register(UserProfileCell.self, forCellReuseIdentifier: UserProfileCell.reuseID)
    }
    
    func displayEmptyView(state: UserProfilesState) {
        DispatchQueue.main.async {
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            
            let emptyView = UserProfilesEmptyStateView(state: state)
            emptyView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(emptyView)
            
            NSLayoutConstraint.activate([
                emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                emptyView.topAnchor.constraint(equalTo: self.view.topAnchor),
                emptyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
}

