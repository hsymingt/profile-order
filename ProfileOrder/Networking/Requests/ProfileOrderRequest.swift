//
//  ProfileOrderRequest.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/28/21.
//

import Foundation

struct ProfileOrderRequest {
    var baseUrl = "http://hinge-ue1-dev-cli-android-homework.s3-website-us-east-1.amazonaws.com"
    var path: String?
    
    init(_ endpoint: ProfileOrderEndpoint) {
        switch endpoint {
        case .getUsers:
            self.path = baseUrl + endpoint.path()
        case .getConfig:
            self.path = baseUrl + endpoint.path()
        }
    }
    
    func url() -> URL? {
        if let path = path {
            return URL(string: path)
        }
        return nil
    }
}
