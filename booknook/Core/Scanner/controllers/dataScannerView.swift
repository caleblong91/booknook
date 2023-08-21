//
//  dataScannerView.swift
//  booknook
//
//  Created by Caleb Long on 8/21/23.
//

import Foundation
import SwiftUI
import VisionKit


struct dataScannerView: UIViewControllerRepresentable {
    
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataTypes: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        let vc = DataScannerViewController(recognizedDataTypes: [recognizedDataTypes],
                                           qualityLevel: .balanced,
                                           recognizesMultipleItems: recognizesMultipleItems,
                                           isGuidanceEnabled: true,
                                           isHighlightingEnabled: true)
        return vc
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        
        uiViewController.stopScanning()
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate{
        @Binding var recognizedItems: [RecognizedItem]
        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("Did Tap On\(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
            
            print("Did add items\(addedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            self.recognizedItems = recognizedItems.filter{item in removedItems.contains(where: {$0.id == item.id }) }
            print("Did Remove Items\(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            
            print("Scanner became unavailable with error: \(error.localizedDescription)")
        }
    }
    
}
