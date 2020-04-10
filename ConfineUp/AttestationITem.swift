//
//  AttestationITem.swift
//  ConfineUp
//
//  Created by prince ondonda on 09/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import Foundation
import CoreData


class AttestationItem: NSManagedObject, Identifiable {
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var qr_code_text: String?
    @NSManaged public var pdf_data: Data?
    @NSManaged public var domicile: String?
    @NSManaged public var  motif: String?
    @NSManaged public var hour: String?
    
    
    func datetoString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR_POSIX")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: self.createdAt!)
        return date
    }
    
}


extension AttestationItem {
    static func getAllAttestationItems() -> NSFetchRequest<AttestationItem> {
        let request: NSFetchRequest<AttestationItem> = AttestationItem.fetchRequest() as! NSFetchRequest<AttestationItem>
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
