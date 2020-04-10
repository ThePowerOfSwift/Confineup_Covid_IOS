//
//  attestations.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import SwiftUI
import CoreData

struct attestations: View {
    @Environment(\.managedObjectContext) var managedContext
    @FetchRequest(fetchRequest: AttestationItem.getAllAttestationItems()) var AttestationItems: FetchedResults<AttestationItem>

    var body: some View {
        NavigationView{
            List {
                ForEach(self.AttestationItems) { attest in
                    NavigationLink(destination: AttestationDetail(attestation: attest)){
                        AttestationRow(attestation: attest)
                    }

                }.onDelete(perform: { (IndexSet) in
                    let deleteItem = self.AttestationItems[IndexSet.first!]
                    self.managedContext.delete(deleteItem)
                    do {
                        try self.managedContext.save()
                    }catch {
                        print(error)
                    }
                })
                
            }

            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Mes attestations"))
        }
    }
}


