//
//  authViewModel.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseFirestoreSwiftTarget

@MainActor
class authViewModel: ObservableObject{
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        print("Signing In")
    }
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
        }catch{
            print("DEBUG: Failed to createUser with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        print("Signing Out...")
    }
    
    func deleteAccount(){
        print("Deleting Account...")
    }
    
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current User Is\(self.currentUser)")
    }
}
