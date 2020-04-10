//
//  AttestaationDetail.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI

struct AttestationDetail: View {
    var attestation: AttestationItem
    @State private var showModal = false
    var body: some View {
            VStack{
                Image(uiImage: generateQRCode(from: attestation.qr_code_text!))
                .interpolation(.none)
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .frame(width:200, height: 200)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .padding(20)
                
                Text(attestation.qr_code_text!).padding(10)


                Spacer()
                    Button(action: {
                    self.showModal.toggle()
                    }) {
                    HStack {
                        Image(systemName: "doc")
                            .font(.body)
                        Text("Afficher le pdf")
                            .fontWeight(.semibold)
                            .font(.body)
                    }.sheet(isPresented: $showModal){
                        PDFKitView(pdf_data: self.attestation.pdf_data!)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(30)
                }
                Spacer()
            }.navigationBarTitle(Text(attestation.datetoString()! + " à " + attestation.hour!))
        
            
        
        
    }
}
