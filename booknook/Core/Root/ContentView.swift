//
//  ContentView.swift
//  booknook
//
//  Created by Caleb Long on 8/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: authViewModel
    var body: some View {
        Group{
            if(viewModel.userSession != nil){
                profileView()
            }
            else{
                loginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView().environmentObject({ () -> authViewModel in
            let envObj = authViewModel()
            return envObj
        }() )
            
    }
    
}


