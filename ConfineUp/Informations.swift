//
//  Informations.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI

struct Informations: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 30){
                VStack (alignment: .leading, spacing: 10){
                    Text("Rien sur aucun serveur").font(.title)
                Text("Nous n’effectuons aucune sauvegarde sur  serveur d’aucune des données que vous générez en utilisant cette application (PDF, QRCODE, Informations personnelles).")
                }.padding(5)
                
                
                VStack (alignment: .leading, spacing: 10){
                Text("Application non affiliée").font(.title)
                 Text("Cette application n’est affiliée ni de près ni de loin au gouvernement Français, elle est le fruit d’une initiative personnelle. ")
                }.padding(5)

                VStack (alignment: .leading, spacing: 10){
                Text("Codes sources disponible").font(.title)
                 Text("Les codes sources de l’application ont été rendu public à l’adresse https://github.com/princefr")
                }.padding(5)

                Spacer()
                }
            .navigationBarTitle(Text("Informations"))
        }
    }
}

struct Informations_Previews: PreviewProvider {
    static var previews: some View {
        Informations()
    }
}
