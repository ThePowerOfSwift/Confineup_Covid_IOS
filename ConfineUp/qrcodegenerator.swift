//
//  qrcodegenerator.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct qrcodegenerator: View {
    @Environment(\.managedObjectContext) var managedContext
    @EnvironmentObject var userdata: UserData
    
    @State var showBanner: Bool = false

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var showingAlert = false
    
    var raisons  = ["Sport", "Travail", "Courses", "Sante", "Famille", "Judiciare", "Missions"]
    @State var alert_text_top: String = ""
    @State var alert_message: String = ""

    @State private var selectedRaison = 0

    
    var body: some View {
        NavigationView {
            VStack{
                Image(uiImage: generateQRCode(from: self.generateString()!))
                .interpolation(.none)
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .frame(width:200, height: 200)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .padding(20)
                
                Text(self.generateString()!).padding(10)

                Form{
                    Picker(selection: $selectedRaison, label: Text("Raison")) {
                         ForEach(0 ..< raisons.count) {
                             Text(self.raisons[$0])
                         }
                     }
                }.listStyle(GroupedListStyle())

            }
            
            .navigationBarTitle(Text("Attestation"))
            .navigationBarItems(trailing:
                Button("Générer") {
                    self.SaveToCoreData()
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text(alert_text_top), message: Text(alert_message), dismissButton: .default(Text("D'accord")))
                }
                
            )
        }
    }
    
    func SaveToCoreData(){
        if self.userdata.first_name.isEmpty || self.userdata.last_name.isEmpty || self.userdata.birth_place.isEmpty || self.userdata.city.isEmpty ||  self.userdata.zip_code.isEmpty || self.userdata.adress.isEmpty || Calendar.current.isDateInToday(self.userdata.birth_date) {
            self.showingAlert = true
            self.alert_text_top = "Profil non complété"
            self.alert_message = "Veuillez remplir votre profil pour generer un pdf"
        }else{
            let str = "Créé le: \(formateDateToString(date: Date())!) a \(formateDateToHourAndMin(date: Date())!); Nom: \(self.userdata.last_name); Prenom: \(self.userdata.first_name); Naissance: \(formateDateToString(date: self.userdata.birth_date) ?? "xxxxx") a \(self.userdata.birth_place); Adresse: \(self.userdata.adress + ", " + self.userdata.zip_code + ", " + self.userdata.city ); Sortie: \(formateDateToString(date: Date())!) a \(formateDateToHourAndMin(date: Date())!); Motifs: \(raisons[selectedRaison])"
                    
            let attesITem = AttestationItem(context: managedContext)
            let date = formateDateToString(date: Date())
            let heure = formateDateToHourAndMin(date: Date())
            attesITem.createdAt = Date()
            attesITem.domicile = "domicile"
            attesITem.hour = heure
            attesITem.id = UUID().uuidString
            attesITem.motif = raisons[selectedRaison]
            attesITem.qr_code_text = str
            attesITem.pdf_data = GeneratePDF(first_name: self.userdata.first_name, last_name: self.userdata.last_name, birth_place: self.userdata.birth_place, birth_date: formateDateToString(date: self.userdata.birth_date)!, adress: self.userdata.adress, city: self.userdata.city, zip_code:self.userdata.zip_code, reason: raisons[selectedRaison], current_date: date!, hour_and_minute: heure!, hour: String(Calendar.current.component(.hour, from: Date())), minute: String(Calendar.current.component(.minute, from: Date())), qrcode_text: str)
            
            do {
                try self.managedContext.save()
                self.showingAlert = true
                self.alert_text_top = "Succès de l'opération"
                self.alert_message = "Vous avez générer une nouvelle attestation"
            }catch{
                print(error)
            }
        }
        
    }
    
    func formateDateToString(date: Date)  -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR_POSIX")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: date)
        return date
    }
    
    func formateDateToHourAndMin(date: Date) -> String? {
        let dateFormatter_hour = DateFormatter()
        dateFormatter_hour.dateFormat = "HH:mm"
        var heure = dateFormatter_hour.string(from: date)
        heure = heure.replacingOccurrences(of: ":", with: "h")
        return heure
    }
    

    
    
    func generateString() -> String? {
        let str = "Créé le: \(formateDateToString(date: Date())!) a \(formateDateToHourAndMin(date: Date())!); Nom: \(self.userdata.last_name); Prenom: \(self.userdata.first_name); Naissance: \(formateDateToString(date: self.userdata.birth_date) ?? "xxxxx") a \(self.userdata.birth_place); Adresse: \(self.userdata.adress + ", " + self.userdata.zip_code + ", " + self.userdata.city ); Sortie: \(formateDateToString(date: Date())!) a \(formateDateToHourAndMin(date: Date())!); Motifs: \(raisons[selectedRaison])"
        
        return str
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
    
    
}



struct qrcodegenerator_Previews: PreviewProvider {
    static var previews: some View {
        qrcodegenerator()
    }
}
