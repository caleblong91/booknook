//
//  RegistrationView.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: authViewModel
    var body: some View {
        VStack{
            //Image
            Image("header")
                .resizable()
                .scaledToFill()
                .frame(width: 10, height:80)
                .padding(.vertical, 100)
            
            VStack(spacing: 24){
                //Username
                inputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                //Fullname
                inputView(text: $fullname,
                          title: "Full Name",
                          placeholder: "Your Name")
                
                //Password
                inputView(text: $password,
                          title: "Password",
                          placeholder: "Enter Your Password",
                          isSecureField: true)
                
                //ConfirmPassword
                inputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Confirm Your Password",
                          isSecureField: true)
            }
            .padding(.horizontal)
            
            Button{
                Task{
                    try await viewModel.createUser(withEmail: email,password: password, fullname: fullname)
                }
            }label: {
                HStack{
                    Text("Sign Up")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack{
                    Text("Already Have an Account")
                    Text("Sign In")
                        .fontWeight(.bold
                        )
                }
                .font(.system(size: 14))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
