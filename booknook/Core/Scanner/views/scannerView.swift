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
    
    private let textContentTypes: [(title:String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("Title/Author", .none)/*,
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress),*/
    ]
    
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
        VStack{
            dataScannerView(recognizedItems: $viewModelApp.recognizedItems, recognizedDataTypes: viewModelApp.recognizedDataType, recognizesMultipleItems: viewModelApp.recognizesMultipleItems)
            .background{Color.gray.opacity(0.3)}
            .ignoresSafeArea()
            .id(viewModelApp.dataScannerViewId)
            
            bottomContainerView.presentationDetents([.medium, .fraction(0.25) ])
                .presentationDragIndicator(.visible)
                .presentationBackground(.clear)
        }
        .onChange(of: viewModelApp.scanType) { _ in viewModelApp.recognizedItems = []}
        .onChange(of: viewModelApp.textContentType) { _ in viewModelApp.recognizedItems = []}
        .onChange(of: viewModelApp.recognizesMultipleItems) { _ in viewModelApp.recognizedItems = []}
    }
    
    private var headerView : some View{
        VStack{
            HStack{
                Picker("Scan Type", selection: $viewModelApp.scanType){
                    Text("Barcode").tag(ScanType.barcode)
                    Text("Text").tag(ScanType.text)
                }.pickerStyle(.segmented)
                
                //Uncomment to allow scanning for multiple items
                //Toggle("Scan Multiple Items", isOn: $viewModelApp.recognizesMultipleItems)
            }.padding(.top)
            
            if viewModelApp.scanType == .text{
                Picker("Text Content Type", selection: $viewModelApp.textContentType){
                    ForEach(textContentTypes, id: \.self.textContentType){ option in
                        Text(option.title).tag(option.textContentType)
                    }
                }.pickerStyle(.segmented)
            }
            Text(viewModelApp.headerText).padding(.top)
        }.padding(.horizontal)
    }
    
    private var bottomContainerView : some View{
        VStack{
            headerView
            ScrollView{
                LazyVStack(alignment:.leading, spacing: 16){
                    ForEach(viewModelApp.recognizedItems){ items in
                        switch items {
                            
                        case .barcode(let barcode):
                            HStack{
                                Text(barcode.payloadStringValue ?? "Unknown Barcode")
                                Spacer()
                                Button("Search"){
                                    //Search for Book based on Barcode
                                }
                            }
                        case .text(let text):
                            HStack{
                                Text(text.transcript)
                                Spacer()
                                Button("Search"){
                                    //Search for Book based on Title
                                }
                            }
                        @unknown default: Text("Unknown")
                        }
                    }
                }
                .padding()
            }
        }
    }
}
