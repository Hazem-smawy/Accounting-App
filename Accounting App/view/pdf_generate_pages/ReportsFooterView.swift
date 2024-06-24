//
//  ReportsFooter.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 14/11/2023.
//

import SwiftUI

struct ReportsFooterView: View {
    @EnvironmentObject var reportVm :ReportsViewModel
    @EnvironmentObject var vm:AccountingAppViewModel
    
    var body: some View {
        if reportVm.totalCredit != 0 || reportVm.totalDebit != 0 {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.green)
                            .font(.callout)
                        
                        Text(vm.curences.first(where: {$0.curencyId == reportVm.curencyId ?? ""})?.curencySymbol ?? "")
                            .customFont(size: 12)
                            .foregroundColor(myColor.textSecondary)
                        Text(Utilies.formattedValue(using: reportVm.totalCredit))
                            .font(.body)
                        Text("لة")
                            .customFont(size: 12)
                            .foregroundColor(myColor.textSecondary)
                        
                    }
                    .padding(5)
                    
                    .frame(maxWidth: .infinity)
                    .background(myColor.containerColor.cornerRadius(5))
                    
                    
                    HStack {
                        Image(systemName: "arrow.down.left")
                            .foregroundColor(.red)
                            .font(.callout)
                        Text(vm.curences.first(where: {$0.curencyId == reportVm.curencyId ?? ""})?.curencySymbol ?? "")
                            .customFont(size: 12)
                            .foregroundColor(myColor.textSecondary)
                        Text(Utilies.formattedValue(using: reportVm.totalDebit))
                            .font(.body)
                        Text("علية")
                            .customFont(size: 12)
                            .foregroundColor(myColor.textSecondary)
                        
                    }
                    .padding(5)
                    
                    .frame(maxWidth: .infinity)
                    .background(myColor.containerColor.cornerRadius(5))
                }
                
                
                HStack {
                    Image(systemName:reportVm.totalCredit > reportVm.totalDebit ? "arrow.up" : "arrow.down")
                        .foregroundColor(reportVm.totalCredit > reportVm.totalDebit ?.green : .red)
                    Text(vm.curences.first(where: {$0.curencyId == reportVm.curencyId ?? ""})?.curencySymbol ?? "")
                        .customFont(size: 12)
                        .foregroundColor(myColor.textSecondary)
                    Text(Utilies.formattedValue(using: abs(reportVm.totalCredit - reportVm.totalDebit)))
                        .font(.headline)
                    Text(reportVm.totalCredit > reportVm.totalDebit ?   "لة":"علية")
                        .customFont(size: 12)
                        .foregroundColor(myColor.textSecondary)
                    
                }
                .padding(5)
                
                .frame(maxWidth: .infinity)
                .background(myColor.containerColor.cornerRadius(5))
                
                
                
            }
            .padding()
            Divider().padding(.top)
                .padding(.horizontal)
            HStack {
                Text(Utilies.formattedDate(date: Date.now))
                    .foregroundColor(.secondary)
                Spacer()
                
                Text("X-Smart")
                    .foregroundColor(.secondary)

            }
            .padding(.horizontal)
        } else {
            Image("customerAccount")
                .resizable()
                .scaledToFit()
        }
           
    }
}

struct ReportsFooter_Previews: PreviewProvider {
    static var previews: some View {
        ReportsFooterView()
            .environmentObject(AccountingAppViewModel())
            .environmentObject(ReportsViewModel())
    }
}
