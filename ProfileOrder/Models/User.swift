//
//  User.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

struct User: Codable {
    let id: Int
    let name: String
    let gender: String
    let about: String?
    let photo: String?
    let school: String?
    let hobbies: [String]?
}

struct UserResponsePayload: Codable {
    let users: [User]
}
