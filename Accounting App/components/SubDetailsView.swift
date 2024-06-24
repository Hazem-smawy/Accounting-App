//
//  SubDetailsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 23/07/2023.
//

import SwiftUI

struct SubDetailsView: View {
    @Binding var selectedJournals :Journal?
    var customerAccount:CustomerAccount
    @EnvironmentObject var vm:AccountingAppViewModel
    @Binding var isPresented:Bool
    
    var detailsStatus :Bool {
        return customerAccount.status && (vm.currentCurency?.status ?? true) && (vm.currentAccGroup?.status ?? true)
    }
    var body: some View {
        VStack(spacing:7) {
            
            //MARK: NAME
            Text(vm.customers.first(where: {$0.customerId == customerAccount.customerId})?.customerName ?? " ")
                .customFont(size: 16,bold: true)
                .padding(.bottom,20)
            //MARK: MONEY
            HStack(spacing: 10) {
                
                Image(systemName:selectedJournals?.credit ?? 0 > selectedJournals?.debit ?? 0 ? "chevron.compact.up" : "chevron.compact.down")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(selectedJournals?.credit ?? 0 > selectedJournals?.debit ?? 0 ? .green : .red)
                Spacer()
                Text("\(Int((selectedJournals?.credit ?? 0) - (selectedJournals?.debit ?? 0)))")
                    .font(.headline)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("المبلغ")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "creditcard")
                    .foregroundColor(myColor.textSecondary)

            }
            Divider()
            
            //MARK: CURENCY
            HStack(spacing: 10) {
                Text(vm.curences.first(where: {$0.curencyId == customerAccount.curencyId})?.curencySymbol ?? " ")
                    .customFont(size: 14)
                    .fontWeight(.bold)
                    .foregroundColor(myColor.textSecondary)
                Spacer()
                Text(vm.curences.first(where: {$0.curencyId == customerAccount.curencyId})?.curencyName ?? " ")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("العمله")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "dollarsign.circle")
                    .foregroundColor(myColor.textSecondary)

            }
            Divider()
            //MARK: DATE
            HStack(spacing: 10) {
              
                Text(Utilies.formattedDate(date: selectedJournals?.registerAt ?? Date.now))
                    .font(.subheadline)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("التأريخ")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "calendar")
                    .foregroundColor(myColor.textSecondary)

            }
            Divider()
            
            HStack(spacing: 10) {
              
                Text(Utilies.formattedTime(date: selectedJournals?.registerAt ?? Date.now))
                    .font(.subheadline)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("الوقت")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "clock")
                    .foregroundColor(myColor.textSecondary)

            }
            Divider()
            //MARK: EDIT DATE
            VStack {
                HStack(spacing: 10) {
                  
                    Text(Utilies.formattedDate(date:  selectedJournals?.modifiedAt ?? Date.now))
                        .font(.subheadline)
                        .foregroundColor(myColor.textPrimary)
                    Spacer()
                    Text("تاريخ التعديل")
                        .customFont(size: 14)
                        .foregroundColor(myColor.textSecondary)
                    Image(systemName: "calendar")
                        .foregroundColor(myColor.textSecondary)

                }
                HStack {
                    Text(Utilies.formattedTime(date:  selectedJournals?.modifiedAt ?? Date.now))
                        .font(.subheadline)
                        .foregroundColor(myColor.textPrimary)
                    Spacer()
                    Text("الوقت")
                        .customFont(size: 14)
                        .foregroundColor(myColor.textSecondary)
                    Image(systemName: "clock")
                        .foregroundColor(myColor.textSecondary)

                }
                .padding(.top,2)
                Divider()
                // MARK: DESCRIPTION
                Text("التفاصيل")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textPrimary)
                
                Text(selectedJournals?.journalDetails ?? " ")
                    .customFont(size: 12)
                    .foregroundColor(myColor.textSecondary)
                    .multilineTextAlignment(.center)
                
                
                CustomBtn(color: detailsStatus ? myColor.primaryColor : .secondary, label: "تعد يل") {
                    if detailsStatus {
                        
                        vm.editedJournal = selectedJournals
                         isPresented.toggle()
                    }
                    else {
                        withAnimation {
                            vm.snakbar = .init(message: "هذا الحساب موقف قم بتغير الاعدادات للتعديل", color: .red, icon: "exclamationmark.triangle.fill")
                          
                            vm.isSnackbarShowing = true
                        }
                    }
                   
                    withAnimation {
                        
                            
                            selectedJournals = nil
                        
                    }
                    
                }
                .padding(.top)
                .padding(.top)
                Text("موافق")
                    .padding(.top,5)
                    .padding(.bottom,5)

                    .customFont(size: 12)
                    .onTapGesture {
                        withAnimation {
                            
                            selectedJournals = nil
                        }
                    }
                
            }
            
           
          
        }
    }
}

//struct SubDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubDetailsView()
//            .padding()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
