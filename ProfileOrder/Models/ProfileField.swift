//
//  ProfileField.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

public enum ProfileField: String {
    case name = "name"
    case photo = "photo"
    case gender = "gender"
    case about = "about"
    case school = "school"
    case hobbies = "hobbies"
    
    func sectionTitle() -> String {
        switch self {
        case .name:
            return "Name"
        case .gender:
            return "Gender"
        case .about:
            return "About"
        case .school:
            return "School"
        case .hobbies:
            return "Hobbies"
        default:
            return ""
        }
    }
    
    func estimatedCellHeight() -> Int {
        switch self {
        case .name:
            return 50
        case .photo:
            return 400
        default:
            return 100
        }
    }
}
