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

enum ScanType: String {
    case barcode, text
}

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
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .barcode
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizesMultipleItems = false //Change to true to allow scanning for multiple items
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType{scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    var headerText: String {
        if recognizedItems.isEmpty{
            return "Scanning \(scanType.rawValue)"
        }else{
            return "Recognized \(recognizedItems.count) item(s)"
        }
    }
    
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizesMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        return hasher.finalize()
    }
    
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

    
}
