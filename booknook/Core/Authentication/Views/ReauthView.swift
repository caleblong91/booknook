//
//  ReauthView.swift
//  booknook
//
//  Created by Caleb Long on 8/9/23.
//

import SwiftUI

struct ReauthView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: authViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack{
            VStack{
                //Image
                if colorScheme == .light {
                    Image("lightHeader").resizable().scaledToFill().frame(width: 10, height:80).padding(.vertical, 100)
                } else {
                    Image("darkHeader").resizable().scaledToFill().frame(width: 10, height:80).padding(.vertical, 100)
                }
                //Image("header").resizable().scaledToFill().frame(width: 10, height:80).padding(.vertical, 100)
                
                VStack(spacing: 24){
                    Text("To Delete Your Account, Please Re-enter Your Email and Password.").font(.headline).multilineTextAlignment(.center).padding(.bottom, 50)
                    
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
                
                
                Button{
                    Task{
                        try await viewModel.reauthDeleteAccount(withEmail: email, password: password)
                    }
                }label: {
                    HStack{
                        Text("Delete Account")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemRed))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()

            }
        }
    }
}

struct ReauthView_Previews: PreviewProvider {
    static var previews: some View {
        ReauthView()
    }
}
