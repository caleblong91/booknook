//
//  profileView.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import SwiftUI

struct profileView: View {
    @EnvironmentObject var viewModelAuth : authViewModel
    var body: some View {
        NavigationStack{
            if let user = viewModelAuth.currentUser{
                List{
                    Section{
                        HStack {
                            Text(user.intials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(user.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Section("General"){
                        HStack{
                            settingsRowView(imagename: "gear",
                                            title: "Version",
                                            tintColor: Color(.systemGray))
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section("Account"){
                        HStack{
                            settingsRowView(imagename: "dollarsign",
                                            title: "Subscription",
                                            tintColor: Color(.systemGray))
                            Spacer()
                        }
                        Button{
                            viewModelAuth.signOut()
                            
                        } label: {
                            settingsRowView(imagename: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                        }
                        
                        NavigationLink{
                            ReauthView()
                        } label: {
                            settingsRowView(imagename: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                            
                        }
                    }
                }
            }
        }
    }
}

struct profileView_Previews: PreviewProvider {    
    static var previews: some View {
        profileView().environmentObject({ () -> authViewModel in
            let envObj = authViewModel()
            return envObj
        }() )
    }
}
