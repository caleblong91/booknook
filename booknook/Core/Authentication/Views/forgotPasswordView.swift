//
//  forgotPasswordView.swift
//  booknook
//
//  Created by Caleb Long on 8/9/23.
//

import SwiftUI

struct forgotPasswordView: View {
    @State private var email = ""
    @State private var codeExecutionSuccessful = false
    @State private var showingAlert = false
    @State private var errorMessage = ""
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
                
                    
                Button("Reset Password") {
                    Task{
                        do{
                            try await codeExecutionSuccessful = viewModel.forgotPasswordEmail(withEmail:email)
                            print("3: \(codeExecutionSuccessful)")
                        }catch{
                            showingAlert = true
                            errorMessage = error.localizedDescription
                        }
                        print("4: \(codeExecutionSuccessful)")
                    }
                }.alert(isPresented: $showingAlert){
                    Alert(
                        title: Text("Error"),
                        message: Text(errorMessage),
                        primaryButton: .default(Text("OK")),
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                               
                NavigationLink(
                    destination: loginView(),
                    isActive: $codeExecutionSuccessful,
                    label: {
                        
                    }
                )
                
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
