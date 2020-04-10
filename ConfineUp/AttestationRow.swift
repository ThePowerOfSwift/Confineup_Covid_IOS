//
//  AttestationRow.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI

struct AttestationRow: View {
    var attestation: AttestationItem

    var body: some View {
        HStack {
            Image(uiImage: generateQRCode(from: attestation.qr_code_text!))
            .interpolation(.none)
            .resizable()
            .frame(width:75, height: 75)
            .aspectRatio(contentMode: .fit)
    
            VStack (alignment: .leading){
                Text(attestation.datetoString()!)
                .font(.system(size: 13))
                Text(attestation.hour!)
                .font(.system(size: 13))
                Text(attestation.motif!)
            }
            
            Spacer()
        }
    }
}


