//
//  forgotPasswordView.swift
//  booknook
//
//  Created by Caleb Long on 8/9/23.
//

import SwiftUI


struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
}

struct forgotPasswordView: View {
    @State private var email = ""
    @State private var codeExecutionSuccessful = false
    @State private var errorMessage = ""
    @State private var alertItem: AlertItem?
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
                            try await viewModel.forgotPasswordEmail(withEmail:email)
                            codeExecutionSuccessful = true
                            self.alertItem = AlertItem(title: Text("Success"), message: Text("Please Check Your Email to Reset Your Password"), dismissButton: .default(Text("OK")))
                        }catch{
                            errorMessage = error.localizedDescription
                            self.alertItem = AlertItem(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                }.alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
                
                NavigationLink(
                    destination: loginView().navigationBarBackButtonHidden(),
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
