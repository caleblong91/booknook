//
//  appViewModel.swift
//  booknook
//
//  Created by Caleb Long on 8/10/23.
//

import Foundation
import SwiftUI
import VisionKit
import AVKit

enum DataScannerAccessType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class appViewModel: ObservableObject {
    
    @Published var dataScannerAccessStatus: DataScannerAccessType = .notDetermined
    
    private var isScannerAvailable : Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    func requestDataScannerAccessStatus() async{
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case.authorized:
            dataScannerAccessStatus = isScannerAvailable ? . scannerAvailable : .scannerNotAvailable
            
        case.restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
            
        case.notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted{
                dataScannerAccessStatus = isScannerAvailable ? . scannerAvailable : .scannerNotAvailable
            } else{
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        default:
        break
        }
    }
    func displayScannerAccess(viewModelApp: appViewModel) -> Text{
        switch viewModelApp.dataScannerAccessStatus{
        case .scannerAvailable:
            return Text("Scanner is Available")
        case .cameraNotAvailable:
            return Text("Camera is not Available")
        case .scannerNotAvailable:
            return Text("Scanner is not Available")
        case .cameraAccessNotGranted:
            return Text("Allow Camera Access in your phones settings")
        case .notDetermined:
            return Text("Requesting Camera Access")
        }
    }
    
}
