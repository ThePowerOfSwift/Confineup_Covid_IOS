//
//  Profil.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI
import Combine

struct Profil: View {
    @EnvironmentObject var userDefaultsData: UserData
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Nom et Prénom")){
                    TextField("Entrer votre nom", text:  self.$userDefaultsData.last_name)
                    TextField("Entrer votre prenom", text: self.$userDefaultsData.first_name)
                }
                
                Section(header: Text("Date et lieu Naissance")){
                    DatePicker(selection: self.$userDefaultsData.birth_date, in: ...Date(), displayedComponents: .date) {
                        Text("Date")
                    }
                    
                    TextField("Lieu de naissance", text: self.$userDefaultsData.birth_place)
                }
                
                Section(header: Text("Adresse")){
                    TextField("adresse", text: self.$userDefaultsData.adress)
                    TextField("Ville", text: self.$userDefaultsData.city)
                    TextField("Code Postal", text: self.$userDefaultsData.zip_code)
                }
                
                Section(header: Text("à propos")){
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("0.0.1")
                    }
                    
                }
                
            }.keyboardResponsive()
            .navigationBarTitle(Text("Mon profil"))
            .navigationBarItems(trailing:
                Button("Sauvegarder") {
                    self.userDefaultsData.save_user_information()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
            )
        }
        
    }
    

}


class UserData: ObservableObject {
    @Published var first_name: String = UserDefaults.standard.string(forKey: "first_name") ?? "xxxx"
    @Published var last_name: String = UserDefaults.standard.string(forKey: "last_name") ?? "xxxx"
    @Published var birth_date = UserDefaults.standard.object(forKey: "birth_date") as? Date ?? Date()
    @Published var birth_place = UserDefaults.standard.string(forKey: "birth_place") ?? "xxxx"
    @Published var city = UserDefaults.standard.string(forKey: "city") ?? "xxxx"
    @Published var zip_code = UserDefaults.standard.string(forKey: "zip_code") ?? "xxxx"
    @Published var adress = UserDefaults.standard.string(forKey: "adress") ?? "xxxx"
    
    func save_user_information() {
        UserDefaults.standard.set(self.first_name, forKey: "first_name")
        UserDefaults.standard.set(self.last_name, forKey: "last_name")
        UserDefaults.standard.set(self.birth_date, forKey: "birth_date")
        UserDefaults.standard.set(self.birth_place, forKey: "birth_place")
        UserDefaults.standard.set(self.city, forKey: "city")
        UserDefaults.standard.set(self.zip_code, forKey: "zip_code")
        UserDefaults.standard.set(self.adress, forKey: "adress")
    }
}



struct Profil_Previews: PreviewProvider {
    static var previews: some View {
        Profil()
    }
}
