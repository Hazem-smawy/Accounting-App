//
//  CustomerAccountsReportView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 13/11/2023.
//

import SwiftUI
import CoreData

struct CustomerAccountsReportView: View {
    @EnvironmentObject var vm:AccountingAppViewModel
    @EnvironmentObject var reportVm:ReportsViewModel
    @State private var customerAccounts:[CustomerAccount] = []
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 300),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 100, maximum: 800), spacing: 10),
    ]
    func fetchCustomersAccount(curencyId:String,accGroupId:String) {
        reportVm.totalDebit = 0
        reportVm.totalCredit = 0
        if curencyId.isEmpty && accGroupId.isEmpty {
            return
        }
        customerAccounts = vm.customersAccount.filter({ customerAccount in
            customerAccount.curencyId == curencyId && customerAccount.accGroupId == accGroupId
        })
        
        customerAccounts.forEach { cac in
            reportVm.totalCredit += cac.totalCredit
            reportVm.totalDebit += cac.totalDebit
        }
    }
    func fetchAllCustomerAccounts(curencyId:String) {
        reportVm.totalDebit = 0
        reportVm.totalCredit = 0
        if curencyId.isEmpty {
            return
        }
        customerAccounts = vm.customersAccount.filter({ customerAccount in
            customerAccount.curencyId == curencyId
        })
        
        customerAccounts.forEach { cac in
            reportVm.totalCredit += cac.totalCredit
            reportVm.totalDebit += cac.totalDebit
        }
    }
    var body: some View {
        ScrollView {
            VStack {
                ReportAppBarView(title: "إجمالي المبالغ") {
                    exportPDF {
                        self
                            .environmentObject(vm)
                            .environmentObject(reportVm)
                    }completion: { status, url in
                        if let url = url ,status {
                            reportVm.PDFUrl = url
                            reportVm.showshareSheet.toggle()
                        }else {
                            print("Field")
                        }
                    }
                }
                HStack {
                    ReportAccGroupView()
                    HStack {
                        Text("الكل")
                            .customFont(size: 12,bold: reportVm.accGroupId == nil ? true : false)
                            .foregroundColor(reportVm.accGroupId == nil ? .green : myColor.textSecondary)
                            .onTapGesture {
                                
                                fetchAllCustomerAccounts(curencyId: reportVm.curencyId ?? vm.curences.first?.curencyId ?? "")
                                reportVm.accGroupId = nil
                            }
                        
                    }
                }
                ReportCurencyView()
                    .padding(.top,-10)
                
                
                
            }
            .padding()
            if !customerAccounts.isEmpty {
                
                CustomerAccountHeaderView()
            }
            ForEach(customerAccounts) { cac in
                LazyVGrid(columns: columns) {
                    Text("\(Int(cac.totalCredit))")
                    
                        .foregroundColor(.green)
                        .font(.body)
                    Text("\(Int(cac.totalDebit))")
                    
                        .foregroundColor(.red)
                        .font(.body)
                    HStack {
                        Text(vm.accGroups.first(where: {$0.accGroupID == cac.accGroupId})?.accGroupName ?? "")
                            .customFont(size: 10)
                            .foregroundColor(myColor.textSecondary)
                        Image(systemName: "folder")
                            .foregroundColor(.secondary)
                            .font(.body)
                    }
                    .frame(maxWidth:.infinity,alignment: .trailing)
                    
                    
                    Text(vm.customers.first(where: {$0.customerId == cac.customerId})?.customerName ?? "")
                        .foregroundColor(myColor.textPrimary)
                        .customFont(size: 12)
                        .multilineTextAlignment(.trailing)
                    
                    
                }
                Divider()
            }
            
            
            ReportsFooterView()
            
            
            
            
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if reportVm.curencyId == nil {
                
                reportVm.curencyId  =  vm.curences.first?.curencyId ?? ""
            }
            if reportVm.accGroupId == nil {
                
                reportVm.accGroupId = vm.accGroups.first?.accGroupID ?? ""
            }
            fetchCustomersAccount(curencyId: reportVm.curencyId ?? "", accGroupId:reportVm.accGroupId ?? "")
        }
        .onChange(of: reportVm.curencyId) { newValue in
            if reportVm.accGroupId == nil {
                fetchAllCustomerAccounts(curencyId: newValue ?? "")
            }else {
                fetchCustomersAccount(curencyId: newValue ?? "", accGroupId:reportVm.accGroupId ?? "")}
        }
        .onChange(of: reportVm.accGroupId) { newValue in
            if reportVm.accGroupId == nil {
                
                fetchAllCustomerAccounts(curencyId: reportVm.curencyId ?? vm.curences.first?.curencyId ?? "")
            }else {
                fetchCustomersAccount(curencyId: reportVm.curencyId ?? "", accGroupId:newValue ?? "")
            }
        }
        .sheet(isPresented: $reportVm.showshareSheet) {
            reportVm.PDFUrl = nil
        } content: {
            if let PDFUrl = reportVm.PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }
    }
}

struct CustomerAccountsReportView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerAccountsReportView()
            .environmentObject(AccountingAppViewModel())
            .environmentObject(ReportsViewModel())
    }
}



struct CustomerAccountHeaderView:View {
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 300),spacing: 10),
        // GridItem(.fixed(30), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 100, maximum: 800), spacing: 10),
        
        
    ]
    var body: some View {
        VStack {
            Divider()
            HStack {
                LazyVGrid(columns: columns) {
                    
                    Text("لة")
                    Text("علية")
                    
                    Text("التصنيف")
                    Text("الأسم")
                }
                
            }
            .customFont(size: 12,bold: true)
            .padding(.vertical,5)
            Divider()
        }
    }
}
