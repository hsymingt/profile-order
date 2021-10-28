//
//  ProfileOrderDataManager.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

import Combine
import Foundation

enum ProfileError: Error {
    case wrappedError(error: Error)
}

class ProfileOrderDataManager {
    var cancellables = Set<AnyCancellable>()
    var defaultConfig = Config(profile: ["name", "photo", "gender", "about", "school", "hobbies"])
    
    /*
        API request to get list of users
     */
    func getUsers() -> AnyPublisher<[User], ProfileError> {
        let getUserRequest = ProfileOrderRequest(.getUsers)
        
        return URLSession.shared.dataTaskPublisher(for: getUserRequest.url()!)
            .map { $0.data }
            .decode(type: UserResponsePayload.self, decoder: JSONDecoder())
            .mapError { ProfileError.wrappedError(error: $0) }
            .map { $0.users }
            .eraseToAnyPublisher()
    }
    
    /*
        API request to get profile configuration
        On failure, response is replaced with the default config defined above
     */
    func getConfig() -> AnyPublisher<[ProfileField], ProfileError> {
        let getConfigRequest = ProfileOrderRequest(.getConfig)

        return URLSession(configuration: .default).dataTaskPublisher(for: getConfigRequest.url()!)
            .map { $0.data }
            .decode(type: Config.self, decoder: JSONDecoder())
            .replaceError(with: defaultConfig)
            .compactMap({ $0.profile.compactMap({ ProfileField(rawValue: $0) }) })
            .setFailureType(to: ProfileError.self)
            .eraseToAnyPublisher()
    }
    
    /*
        Combines the responses of getUsers and getConfig requests
     */
    func getProfilesAndConfig(completion: @escaping (Result<(([User], [ProfileField])), ProfileError>) -> Void) {
        Publishers.Zip(getUsers(), getConfig())
            .sink(
                receiveCompletion: { finished in
                    switch finished {
                    case.failure(let error):
                        completion(.failure(error))
                    case .finished:
                        return
                    }
            },
                receiveValue: { (users, config) in
                    completion(.success((users, config)))
            })
            .store(in: &cancellables)
    }
}
