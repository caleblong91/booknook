//
//  user.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    let subscription: String
   
    //Grabs initals from fullname to use in profile view
    //To-do use avatars or images
    var intials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Steve Perry", email: "test@gmail.com", subscription: "Paid")
    
}
