//
//  CustomerAccountDetailsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 26/07/2023.
//

import SwiftUI

struct CustomerAccountDetailsView: View {
    @Binding var  cac:CustomerAccount?
    @EnvironmentObject var vm:AccountingAppViewModel
    @State private var status:Bool = true

    var body: some View {
        VStack {
            
            VStack {
                HStack(spacing: 10) {
                    
                    Toggle("", isOn:  $status)
                        .labelsHidden()
                        .onChange(of: status) { newValue in
                            cac?.status = status
                            vm.saveCustomersAccount()
                        }
                        
                        
                    Spacer()
                    Text("حالة الحساب")
                        .customFont(size: 14)
                    
                    Image(systemName: "checkmark.circle")
                    
                }
                .foregroundColor(cac?.status ?? true ? .green : .red)

                HStack {
                    HStack {
                        Text(Utilies.formattedValue(using:abs( cac?.totalCredit ?? 0)))
                            .font(.headline)
                        Text("عليه :")
                        
                        Image(systemName: "arrow.down")
                            .resizable()
                            .frame(width: 12,height: 12)
                            .font(.title)
                            .foregroundColor(.red)

                    }
                    .padding()
                    
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .background(myColor.containerColor)
                    .cornerRadius(12)
                    Spacer()
                    HStack {
                        
                        Text(Utilies.formattedValue(using:abs( cac?.totalDebit ?? 0)))
                            .font(.headline)
                        Text("له :")
                        
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 12,height: 12)
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .background(myColor.containerColor)
                    .cornerRadius(12)
                }
                .customFont(size: 12)
                //MARK: MONEY
                HStack(spacing: 10) {
                    
                    Text("\(vm.customers.first(where: {$0.customerId == cac?.customerId})?.customerName ?? "")")
                        .customFont(size: 14)
                        .foregroundColor(myColor.textPrimary)

                    
                    Spacer()
                   
                    Spacer()
                    Text("اسم العميل")
                        .customFont(size: 14)
                        .foregroundColor(myColor.textSecondary)
                    Image(systemName: "person")
                        .foregroundColor(myColor.textSecondary)
                    
                }
                Divider()
            }
         
            HStack(spacing: 10) {
                
                Text("\(vm.accGroups.first(where: {$0.accGroupID == cac?.accGroupId})?.accGroupName ?? "")")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textPrimary)

                
                Spacer()
               
                Spacer()
                Text(" التصنيف")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "folder")
                    .foregroundColor(myColor.textSecondary)
                
            }
            Divider()
            
            //MARK: CURENCY
            HStack(spacing: 10) {
                Text("\(vm.curences.first(where: {$0.curencyId == cac?.curencyId})?.curencyName ?? "")")
                    .customFont(size: 14)
                    .fontWeight(.bold)
                    .foregroundColor(myColor.textSecondary)
                Spacer()
                Text("\(vm.curences.first(where: {$0.curencyId == cac?.curencyId})?.curencySymbol ?? "")")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("العملة")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "dollarsign.circle")
                    .foregroundColor(myColor.textSecondary)
                
            }
            Divider()
            //MARK: DATE
            HStack(spacing: 10) {
                
                Text(Utilies.formattedDate(date: cac?.createdAt ?? Date.now))
                    .font(.subheadline)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("تأريخ الإنشاء")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "calendar")
                    .foregroundColor(myColor.textSecondary)
                
            }
            Divider()
            
            HStack(spacing: 10) {
                
                Text(Utilies.formattedTime(date: cac?.createdAt ?? Date.now))
                    .font(.subheadline)
                    .foregroundColor(myColor.textPrimary)
                Spacer()
                Text("الوقت")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                Image(systemName: "clock")
                    .foregroundColor(myColor.textSecondary)
                
            }
          
           Spacer()
            
          
            
            
            
        }
        .onAppear {
            status = cac?.status ?? true
        }
        
        .padding()
        .padding()
    }
}

//struct CustomerAccountDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerAccountDetailsView()
//
//    }
//}
