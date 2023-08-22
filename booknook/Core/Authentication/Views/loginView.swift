//
//  loginView.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import SwiftUI


struct loginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: authViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //Image
                Image("header").resizable().scaledToFill().frame(width: 10, height:80).padding(.vertical, 100)
                
                VStack(spacing: 24){
                    //Username
                    inputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    //Password
                    inputView(text: $password,
                              title: "Password",
                              placeholder: "Enter Your Password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                
                //Forgot Password TO-DO
                NavigationLink{
                    forgotPasswordView()
                } label: {
                    HStack{
                        Spacer()
                        Text("Forgot Password")
                            .fontWeight(.bold
                            ).font(.footnote).padding(.trailing, 50)
                    }
                    .font(.system(size: 14))
                }
                //Sign In Button
                Button(){
                    Task{
                        do{
                            try await viewModel.signIn(withEmail: email, password: password)
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }label: {
                    HStack{
                        Text("Sign In")
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
                //Create Account
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack{
                        Text("Don't Have an Account")
                        Text("Sign Up")
                            .fontWeight(.bold
                            )
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
