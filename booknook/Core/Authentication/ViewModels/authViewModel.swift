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
import UIKit

protocol AuthenticationFormProtocol {
    var formIsValid : Bool {get}
}

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
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch{
            print("DEBUG: Failed to Sign In with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch{
            print("DEBUG: Failed to createUser with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch{
            print("DEBUG:Failed to Sign Out with Error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(){
        let user = Auth.auth().currentUser
        guard let uid = Auth.auth().currentUser?.uid else {return}
        user?.delete { error in
          if let error = error {
              print("DEBUG:Failed to Delete Account \(error.localizedDescription)")
          } else {
              self.userSession = nil
              self.currentUser = nil
              Firestore.firestore().collection("users").document(uid).delete()
              print("Account Deleted...")
          }
        }
    }
    
    func reauthDeleteAccount(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            deleteAccount()
        } catch{
            print("DEBUG: Failed to Sign In with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current User Is\(String(describing: self.currentUser))")
    }
    
    func forgotPasswordEmail(withEmail email: String) async throws{
       //Need to use universal deep links to do reset in app
        do{
           try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch{
            print("DEBUG: Failed to send email with error\(error.localizedDescription)")
            throw error
        }
    }
}
