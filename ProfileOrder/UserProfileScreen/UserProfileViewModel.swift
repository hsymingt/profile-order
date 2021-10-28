//
//  UserProfileViewModel.swift
//  ProfileOrder
//
//  Created by Harriet Symington on 10/27/21.
//

struct UserProfileViewModel {
    
    var fieldsDisplayOrder: [(ProfileField, String)]

    /*
        fieldsDisplayOrder initialized with the user's profile fields in the order specified by config
     */
    init(from user: User, with config: [ProfileField]) {
        fieldsDisplayOrder = []
        for field in config {
            switch field {
            case .name:
                fieldsDisplayOrder.append((.name, user.name))
            case .gender:
                let gender = (user.gender == "m") ? "Male" : (user.gender == "f") ? "Female" : "Non Binary"
                fieldsDisplayOrder.append((.gender, gender))
            case .about:
                if let about = user.about {
                    fieldsDisplayOrder.append((.about, about))
                }
            case .photo:
                if let photoUrl = user.photo {
                    fieldsDisplayOrder.append((.photo, photoUrl))
                }
            case .school:
                if let school = user.school {
                    fieldsDisplayOrder.append((.school, school))
                }
            case .hobbies:
                if let hobbies = user.hobbies {
                    let hobbyString = hobbies.joined(separator: ", ")
                    fieldsDisplayOrder.append((.hobbies, hobbyString))
                }
            }
        }
    }
}
