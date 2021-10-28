//
//  ProfileOrderEndpoint.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/28/21.
//

enum ProfileOrderEndpoint {
    case getUsers
    case getConfig
    
    func path() -> String {
        switch self {
        case .getUsers:
            return "/users"
        case .getConfig:
            return "/config"
        }
    }
}
