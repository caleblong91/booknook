//
//  profileView.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import SwiftUI

struct profileView: View {
    var body: some View {
        List{
            Section{
                HStack {
                    Text(User.MOCK_USER.intials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text(User.MOCK_USER.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text(User.MOCK_USER.email)
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
                    
                    Text(User.MOCK_USER.subscription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Button{
                    print("Sign Out...")
                } label: {
                    settingsRowView(imagename: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                }
                Button{
                    print("Deleting Account...")
                } label: {
                    settingsRowView(imagename: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                }
            }
            
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
