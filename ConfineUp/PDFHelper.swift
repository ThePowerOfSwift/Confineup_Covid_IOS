//
//  PDFHelper.swift
//  ConfineUp
//
//  Created by prince ondonda on 08/04/2020.
//  Copyright © 2020 prince ondonda. All rights reserved.
//

import Foundation
import PDFKit



func LoadPDF(filename:String) -> PDFDocument? {
    let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "pdf")
    let pdf_doc = PDFDocument(url: fileURL!)
    return pdf_doc
}

func InsertInPDF(firstname:String, lastName: String, birthday: String, lieunaissance: String, address: String, town: String, zipcode: String, reason:String) {
    
}


func addAnnotation(x:Int, y:Int, text: String, view: PDFView){
    let rect = CGRect(x: x, y: y, width: 250, height: 20)
    let annotation = PDFAnnotation(bounds: rect, forType: .freeText, withProperties: nil)
    annotation.contents = text
    annotation.font = UIFont.systemFont(ofSize: 13.0)
    annotation.fontColor = .black
    annotation.color = .clear
    guard let document = view.document else { return }
    let FirstPage = document.page(at: 0)
    FirstPage?.addAnnotation(annotation)

}


class PDFImageAnnotation: PDFAnnotation {
    var image: UIImage?
    

    convenience init(_ image: UIImage?, bounds: CGRect, properties: [AnyHashable : Any]?) {
        self.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp, withProperties: properties)
        self.image = image


    }

    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        super.draw(with: box, in: context)

        // Drawing the image within the annotation's bounds.
        guard let cgImage = image?.cgImage else { return }
        context.interpolationQuality = .none
        context.draw(cgImage, in: bounds)
    }
}

func addImageAnnotation(image: UIImage, view: PDFView){
    guard let document = view.document else { return }
    let FirstPage = document.page(at: 0)
    let rect = CGRect(x: (FirstPage?.bounds(for: PDFDisplayBox.mediaBox).size.width)! - 120, y: 175, width: 82, height: 82)
    let imageAnnotation = PDFImageAnnotation(image, bounds: rect, properties: nil)
    FirstPage?.addAnnotation(imageAnnotation)
}



func GeneratePDF(first_name: String, last_name: String, birth_place:String, birth_date:String, adress:String, city: String, zip_code:String, reason:String, current_date:String, hour_and_minute:String, hour:String, minute:String, qrcode_text:String)
    -> Data? {
    let url =  Bundle.main.url(forResource: "certificate", withExtension: "pdf")
    let pdfView = PDFView()
    pdfView.document = PDFDocument(url: url!)
    pdfView.autoScales = true
    
    addAnnotation(x: 123, y: 680, text: last_name + " " + first_name, view: pdfView)
    addAnnotation(x: 123, y: 656, text: birth_date, view: pdfView)
    addAnnotation(x: 92, y: 633, text: birth_place, view: pdfView)
    addAnnotation(x: 134, y: 608, text: adress + " " + zip_code + " " + city, view: pdfView)
    
    // Fait À
    addAnnotation(x: 111, y: 221, text: city, view: pdfView)
    
    
    switch reason.lowercased() {
        case "travail":
            addAnnotation(x: 76, y: 522, text: "X", view: pdfView)
        case "courses":
            addAnnotation(x: 76, y: 473, text: "X", view: pdfView)
        case "sante":
            addAnnotation(x: 76, y: 431, text: "X", view: pdfView)
        case "famille":
            addAnnotation(x: 76, y: 395, text: "X", view: pdfView)
        case "sport":
            addAnnotation(x: 76, y: 340, text: "X", view: pdfView)
        case "judiciaire":
            addAnnotation(x: 76, y: 293, text: "X", view: pdfView)
        case "missions":
            addAnnotation(x: 76, y: 255, text: "X", view: pdfView)
        default:
            print("")
    }
    
    
    if !reason.isEmpty {
        // Date sortie
        addAnnotation(x: 92, y: 195, text: current_date, view: pdfView)
        addAnnotation(x: 196, y: 196, text: hour, view: pdfView)
        addAnnotation(x: 220, y: 196, text: minute, view: pdfView)
    }
    
    addAnnotation(x: 464, y: 160, text: "Date de création", view: pdfView)
    addAnnotation(x: 455, y: 144, text: current_date + " à " + hour_and_minute, view: pdfView)
    let image = generateQRCode(from: qrcode_text)
    
    addImageAnnotation(image: image, view: pdfView)
    return SavePDF(view: pdfView)
}




func SavePDF(view: PDFView) -> Data? {
    let data = view.document?.dataRepresentation()
    return data
}
