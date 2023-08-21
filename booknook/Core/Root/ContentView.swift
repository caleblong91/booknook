//
//  ContentView.swift
//  booknook
//
//  Created by Caleb Long on 8/3/23.
//

import SwiftUI
import FirebaseAppCheck

struct ContentView: View {
    @EnvironmentObject var viewModel: authViewModel
    @EnvironmentObject var viewModelApp: appViewModel
    
    var body: some View {
        viewModelApp.displayScannerAccess(viewModelApp: viewModelApp)
        Group{
            if(viewModel.userSession != nil){
                homePage()
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


