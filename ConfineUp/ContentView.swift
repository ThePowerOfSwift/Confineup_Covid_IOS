//
//  ContentView.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            qrcodegenerator()
            .tabItem {
               Image(systemName: "square.and.pencil")
               Text("Générer")
             }
            
            attestations()
            .tabItem {
                 Image(systemName: "tray.full")
                 Text("Mes attestations")
               }
            
            Informations()
                .tabItem{
                    Image(systemName: "info.circle")
                    Text("Informations")
            }
            
            Profil()
              .tabItem {
                 Image(systemName: "person")
                 Text("Mon profil")
               }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")

    if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
}
