//
//  settingsRowView.swift
//  booknook
//
//  Created by Caleb Long on 8/8/23.
//

import SwiftUI


struct settingsRowView: View {
    let imagename: String
    let title: String
    let tintColor: Color
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imagename)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
    }
}
