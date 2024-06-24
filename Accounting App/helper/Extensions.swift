//
//  Extensions.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 18/11/2023.
//

import SwiftUI

extension View {
    //MARK: extraction views height and width
    func convertToScrollView<Content: View>(@ViewBuilder content:@escaping ()-> Content)-> UIScrollView {
        let scrollView = UIScrollView()
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        
        let constrains = [
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor), hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //width anchor
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
        
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(constrains)
        scrollView.layoutIfNeeded()
        
    
        
        return scrollView
    }
    
    // export to PDF
    
    func exportPDF<Content: View>(@ViewBuilder content:@escaping ()-> Content, completion:@escaping (Bool,URL?) -> ()) {
       
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("output\(UUID().uuidString).pdf")
        let pdfView = convertToScrollView {
            content()
        }
        pdfView.tag = 1009
        let size = pdfView.contentSize
        pdfView.frame = CGRect(x: 0, y: getSafeArea().top, width: size.width, height: size.height)
        
        getRootController().view.insertSubview(pdfView, at: 0)
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do {
            try renderer.writePDF(to: outputFileURL, withActions: {context in
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            
            completion(true,outputFileURL)
            
        }catch {
            completion(false,nil)
            print(error.localizedDescription)
        }
        getRootController().view.subviews.forEach { view in
            if view.tag == 1009 {
                view.removeFromSuperview()
            }
        }
    }
    
    func screenBounds ()-> CGRect {
        return UIScreen.main.bounds
    }
    
    func getRootController () -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}

extension Date {
    static func from(_ year: Int, _ month: Int, _ day: Int) -> Date
    {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(calendar: gregorianCalendar, year: year, month: month, day: day)
        return gregorianCalendar.date(from: dateComponents) ?? Date.now
    }
}
