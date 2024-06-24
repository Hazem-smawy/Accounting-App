//
//  SwiftUIView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 13/11/2023.
//

import SwiftUI

struct ReportsSheet: View {
    var body: some View {
       
            VStack {
                
                    
                   
                   
                NavigationLink(destination: CustomerAccountsReportView().environment(\.layoutDirection, .leftToRight)) {
                        
                        
                      ReportSheetItem(text: "إجمالي المبالغ")
                    }
                    NavigationLink(destination: DailyReportView().environment(\.layoutDirection, .leftToRight)) {


                      ReportSheetItem(text:"القيود اليومية")
                    }
                
                
                    
                   
                   
                    NavigationLink(destination: AccGroupsReportView().environment(\.layoutDirection, .leftToRight)) {
                        
                        
                      ReportSheetItem(text: "إجمالي التصنيفات")
                    }
                    NavigationLink(destination: MovementMoneyReportView().environment(\.layoutDirection, .leftToRight)) {
                        
                        
                      ReportSheetItem(text:"حركة الحسابات")
                    }
                
            
          
        }
            
    }
}

struct ReportsSheet_Previews: PreviewProvider {
    static var previews: some View {
        ReportsSheet()
    }
}

struct ReportSheetItem:View {
    var text :String
    var body: some View {
       
            
            
            HStack(spacing: 10) {
                Image(systemName: "doc.text")
                Text(text)
                    .customFont(size: 12)
                
            }
            .foregroundColor(.white.opacity(0.7))
            .padding(.horizontal,15)
            .padding(.vertical,5)
            .padding(.top,5)
            .frame(maxWidth: .infinity,alignment: .leading)

            
        
    }
}
