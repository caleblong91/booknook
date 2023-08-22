//
//  scannerView.swift
//  booknook
//
//  Created by Caleb Long on 8/10/23.
//

import SwiftUI
import Foundation
import VisionKit


struct scannerView: View {
    @EnvironmentObject var viewModelApp: appViewModel
    
   
    var body: some View {
        switch viewModelApp.dataScannerAccessStatus{
        case .scannerAvailable:
            mainView
        case .cameraNotAvailable:
            Text("Camera is not Available")
        case .scannerNotAvailable:
            Text("Scanner is not Available")
        case .cameraAccessNotGranted:
            Text("Allow Camera Access in your phones settings")
        case .notDetermined:
            Text("Requesting Camera Access")
        }
    }
    
    private var mainView : some View{
        dataScannerView(recognizedItems: $viewModelApp.recognizedItems, recognizedDataTypes: viewModelApp.recognizedDataType, recognizesMultipleItems: viewModelApp.recognizesMultipleItems)
    }
}

struct scannerView_Previews: PreviewProvider {
    static var previews: some View {
        scannerView()
    }
}
