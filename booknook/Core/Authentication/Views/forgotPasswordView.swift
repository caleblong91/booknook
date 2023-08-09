//
//  forgotPasswordView.swift
//  booknook
//
//  Created by Caleb Long on 8/9/23.
//

import SwiftUI

struct forgotPasswordView: View {
    @State private var email = ""
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
                }
                .padding(.horizontal).padding(.bottom,25)
                
                NavigationLink{
                    //RegistrationView()
                       
                } label: {
                    
                        Button{
                            Task{
                                try await viewModel.forgotPasswordEmail(withEmail:email)
                            }
                        } label:{
                            HStack{
                                Text("Reset Password")
                                .fontWeight(.bold
                                )
                            }.foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        }.background(Color(.systemBlue))
                            .cornerRadius(10)
                    
                }
                Spacer()
            }
        }
    }
}

struct forgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        forgotPasswordView()
    }
}
