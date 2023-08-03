//
//  ContentView.swift
//  booknook
//
//  Created by Caleb Long on 8/3/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.init(red: 252.0, green: 252.0, blue: 252.0, alpha: 1.0)).ignoresSafeArea()
            
            VStack{
                Image("logo").resizable().cornerRadius(15).aspectRatio(contentMode: .fit)
            }
        }
        
      
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
    
}


