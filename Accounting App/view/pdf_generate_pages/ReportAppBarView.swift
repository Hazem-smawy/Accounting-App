//
//  ReportAppBarView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 13/11/2023.
//

import SwiftUI
@MainActor
struct ReportAppBarView: View {
    let title:String
    let action:()-> Void
    @Environment(\.dismiss) var dismis
    var body: some View {
        HStack {
           
               
            Image(systemName: "square.and.arrow.up")
                .padding(.leading,10)
                .onTapGesture {
                    action()
                }
                
            Spacer()
            HStack {
                
                Text(title)
                    .customFont(size: 12)
                
                Image(systemName: "chevron.forward")
                    .padding(.trailing,8)
            }
            .onTapGesture {
                dismis()
            }
            
            
               
        }
        .foregroundColor(myColor.bgColor)
        
        .padding(7)
        .background(myColor.blackColor.cornerRadius(10))
        .padding(.top)
        
    }

//     func render() -> URL {
//        // 1: Render Hello World with some modifiers
//        let renderer = ImageRenderer(content:
//
//            view
//
//
//
//        )
//
//        // 2: Save it to our documents directory
//        let url = URL.documentsDirectory.appending(path: "\(name).pdf")
//
//        // 3: Start the rendering process
//        renderer.render { size, context in
//            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
//            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//
//            // 5: Create the CGContext for our PDF pages
//            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
//                return
//            }
//
//            // 6: Start a new PDF page
//            pdf.beginPDFPage(nil)
//
//
//            // 7: Render the SwiftUI view data onto the page
//            context(pdf)
////            pdf.scaleBy(x: 10, y: 10)
//            // 8: End the page and close the file
//            pdf.endPDFPage()
//            pdf.closePDF()
//        }
//
//        return url
//    }

}

//struct ReportAppBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportAppBarView(action: () {})
//    }
//}
