//
//  ReportCurencyView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 13/11/2023.
//

import SwiftUI

struct ReportCurencyView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @EnvironmentObject var reportVm :ReportsViewModel
    
    
     var body: some View {
         HStack {
             ScrollView(.horizontal) {
                 HStack {
                     ForEach(vm.curences, id: \.self){ option in
                         RadioButtonView(label: option.curencyName ?? "", isSelected: option.curencyId == reportVm.curencyId) {
                             
                             reportVm.curencyId = option.curencyId
                          
                             
                         }
                         .padding(.horizontal,10)
                     }
                 }
             }
             .environment(\.layoutDirection, .rightToLeft)

             

         }
         .padding(7)
         .background(myColor.textSecondary.opacity(0.2).cornerRadius(10))
         .onAppear {
             reportVm.curencyId = vm.curences.first?.curencyId
         }
        
         

        
     }

}

struct ReportAccGroupView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @EnvironmentObject var reportVm :ReportsViewModel
    
    
    
     
     var body: some View {
         HStack {
             ScrollView(.horizontal,showsIndicators: false) {
                 HStack {
                   
                     ForEach(vm.accGroups, id: \.self){ option in
                         RadioButtonView(label: option.accGroupName ?? "", isSelected: option.accGroupID == reportVm.accGroupId) {
                             
                             reportVm.accGroupId = option.accGroupID
                           
                             
                         }
                         .padding(.horizontal,10)

                     }
                 }
                 
             }
             .environment(\.layoutDirection, .rightToLeft)

             
             
         }
         .padding(7)
         .background(myColor.textSecondary.opacity(0.2).cornerRadius(10))
         .frame(maxWidth: .infinity,alignment: .center)
         .onAppear {
             reportVm.accGroupId = vm.accGroups.first?.accGroupID
         }
        
         
        
     }

}

struct ReportCurencyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                ReportCurencyView()
                ReportAccGroupView()
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}
