//
//  DailyReportView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 14/11/2023.
//

import SwiftUI

struct DailyReportView: View {
    @State private var journals :[DailyModel] = []
    
    @EnvironmentObject var vm:AccountingAppViewModel
    @EnvironmentObject var reportVm :ReportsViewModel
    @State private var fromDate = Date.from(2023, 1, 1)
    @State private var toDate = Date.now
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 200),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 700), spacing: 10),
        
        
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    ReportAppBarView(title: "القيود اليومية") {
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
                    VStack(spacing: 5) {
                        
                        
                        HStack {
                            Spacer()
                            HStack {
                                
                                Text(Utilies.formattedDate(date: toDate))
                                    .font(.system(size: 12))
                                
                                    .foregroundColor(myColor.textSecondary)
                                    .overlay {
                                        DatePicker(
                                            "",
                                            selection: $toDate,
                                            in:Date.from(2023, 1, 1)...Date.now,
                                            displayedComponents: .date
                                        )
                                        .blendMode(.destinationOver)
                                    }
                                Image(systemName: "calendar")
                                    .font(.system(size: 15))
                                
                                    .foregroundColor(myColor.textSecondary)
                            }
                            .padding(.horizontal,10)
                            .padding(.vertical,5)
                            .background(myColor.containerColor)
                            .cornerRadius(8)
                            
                            
                            Text("الى")
                                .customFont(size: 12)
                                .fontWeight(.bold)
                            
                            
                            HStack {
                                
                                Text(Utilies.formattedDate(date: fromDate))
                                    .font(.system(size: 12))
                                    .foregroundColor(myColor.textSecondary)
                                    .overlay {
                                        DatePicker(
                                            "",
                                            selection: $fromDate,
                                            in:...Date.now,
                                            displayedComponents: .date
                                        )
                                        .blendMode(.destinationOver)
                                    }
                                Image(systemName: "calendar")
                                    .font(.system(size: 15))
                                
                                    .foregroundColor(myColor.textSecondary)
                            }
                            .padding(.horizontal,10)
                            .padding(.vertical,5)
                            .background(myColor.containerColor)
                            .cornerRadius(8)
                            
                            
                            Spacer()
                            
                            
                            
                            
                            
                        }
                        
                        //curency
                        ReportCurencyView()
                    }
                    
                    
                    
                }
                .padding()
                
                
                //MARK: list and footer
                DailyTableHeaderView()
                ForEach(journals,id: \.self) { journal in
                    
                    
                    LazyVGrid(columns: columns) {
                        Text(Utilies.formattedDate(date: journal.journal.registerAt ?? Date.now))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(myColor.textSecondary)
                            .font(.system(size: 9))
                            .padding(.leading)
                        
                        Text(Utilies.formattedValue(using: journal.journal.debit))
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .font(.body)
                        
                        Text(Utilies.formattedValue(using: journal.journal.credit))
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .font(.body)
                        
                        Text(vm.accGroups.first(where: {$0.accGroupID == journal.accGroupId})?.accGroupName ?? "")
                            .customFont(size: 12)
                            .foregroundColor(myColor.textSecondary)
                        
                        
                        HStack {
                            Text(vm.customers.first(where: {$0.customerId == journal.customerId})?.customerName ?? "")
                                .foregroundColor(myColor.textPrimary)
                                .customFont(size: 12)
                                .multilineTextAlignment(.trailing)
                        }
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.trailing)
                        
                        
                        
                        
                    }
                    Divider()
                }
                
                
                
                
                ReportsFooterView()
            }
            .onChange(of: reportVm.curencyId, perform: { newValue in
                fromDate = Date.from(2023, 1, 1)
                toDate = Date.now
                
                getTheJournals()
            })
            .onChange(of: fromDate, perform: { newValue in
                getTheJournals()
            })
            .onChange(of: toDate, perform: { newValue in
                getTheJournals()
            })
            
            .onAppear {
                
                if reportVm.curencyId == nil {
                    
                    reportVm.curencyId = vm.curences.first?.curencyId ?? nil
                }
                
                if reportVm.curencyId != nil {
                    getTheJournals()
                }
                
                
            }
            .frame(maxHeight: .infinity,alignment: .top)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $reportVm.showshareSheet) {
                reportVm.PDFUrl = nil
            } content: {
                if let PDFUrl = reportVm.PDFUrl {
                    ShareSheet(urls: [PDFUrl])
                }
            }
            
            
        }
        
    }
    
    
    func getTheJournals() {
        
        journals = []
        reportVm.totalDebit = 0
        reportVm.totalCredit = 0
        let cacs = vm.customersAccount.filter({$0.curencyId == reportVm.curencyId})
        if cacs.isEmpty {
            return
        }
        var newJournals:[DailyModel] = []
        cacs.forEach { cac in
            let js = cac.journals?.allObjects as? [Journal] ?? []
            js.filter({$0.registerAt ?? Date.now > fromDate && $0.registerAt ?? Date.now < toDate}).forEach { j in
                reportVm.totalDebit += j.debit
                reportVm.totalCredit += j.credit
                newJournals.append(DailyModel(customerId: cac.customerId ?? "", accGroupId: cac.accGroupId ?? "", modifiedAt: cac.modifiedAt ?? Date.now, journal: j))
            }
        }
        newJournals = newJournals.sorted(by: { a, b in
            a.journal.createdAt ?? Date.now < b.journal.createdAt ?? Date.now
            
        })
        
        
        
        
        
        journals = newJournals
        
        
    }
}

struct DailyReportView_Previews: PreviewProvider {
    static var previews: some View {
        DailyReportView()
    }
}

struct DailyTableHeaderView:View {
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 200),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 700), spacing: 10),
        
        
    ]
    var body: some View {
        VStack {
            Divider()
            HStack {
                LazyVGrid(columns: columns) {
                    
                    Text("التأريخ")
                    Text("علية")
                    Text("لة")
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


struct DailyModel:Hashable {
    var customerId :String
    var accGroupId :String
    var modifiedAt:Date
    var journal:Journal
    
}
