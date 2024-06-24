//
//  MovementMoneyReportView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 14/11/2023.
//

import SwiftUI

struct MovementMoneyReportView: View {
    @State private var searchText = ""
    @State private var fromDate = Date()
    @State private var toDate = Date()
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 100),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
       
        GridItem(.flexible(minimum: 100, maximum: 500), spacing: 10),
       
        
    ]
    @Environment(\.dismiss) var dismis
    
    @State private var searchList :[CustomerAccount] = []
    @State private var customerAccount:CustomerAccount? = nil
    @State private var journals :[Journal] = []

    
    @EnvironmentObject var vm:AccountingAppViewModel
    @EnvironmentObject var reportsVm :ReportsViewModel
    @State private var customerId:String = ""
    @State private var isSearchListShowing = false;
    

    var body: some View {
        ZStack(alignment:.top) {
            ScrollView {
                VStack {
                    
                    VStack {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .onTapGesture {
                                    exportPDF {
                                        self
                                        .environmentObject(vm)
                                        .environmentObject(reportsVm)
                                    }completion: { status, url in
                                        if let url = url ,status {
                                            reportsVm.PDFUrl = url
                                            reportsVm.showshareSheet.toggle()
                                        }else {
                                            print("Field")
                                        }
                                    }
                                }
                            TextField("بحث في حسابات العملاء ", text: $searchText)
                                .frame(maxWidth: .infinity)
                                .padding(7)
                                .padding(.horizontal)
                            
                                .background {Capsule().fill(myColor.containerColor)}
                                .multilineTextAlignment(.trailing)
                                .customFont(size: 14)
                            
                            
                            Image(systemName: "arrow.right")
                                .onTapGesture {
                                    dismis()
                                }
                            
                            
                        }
                        .padding(.top)
                        
                        
                        
                        
//                        HStack {
//                            Spacer()
//                            HStack {
//
//                                Text(Utilies.formattedDate(date: toDate))
//                                    .font(.system(size: 11))
//
//                                    .foregroundColor(myColor.textSecondary)
//                                    .overlay {
//                                        DatePicker(
//                                            "",
//                                            selection: $toDate,
//                                            displayedComponents: .date
//                                        )
//                                        .blendMode(.destinationOver)
//                                    }
//                                Image(systemName: "calendar")
//                                    .font(.system(size: 14))
//
//                                    .foregroundColor(myColor.textSecondary)
//                            }
//                            .padding(.horizontal,10)
//                            .padding(.vertical,5)
//                            .background(myColor.containerColor)
//                            .cornerRadius(8)
//
//
//                            Text("الى")
//                                .customFont(size: 12)
//                                .fontWeight(.bold)
//
//
//                                HStack {
//
//                                    Text(Utilies.formattedDate(date: fromDate))
//                                        .font(.system(size: 11))
//                                        .foregroundColor(myColor.textSecondary)
//                                        .overlay {
//                                            DatePicker(
//                                                "",
//                                                selection: $fromDate,
//                                                displayedComponents: .date
//                                            )
//                                            .blendMode(.destinationOver)
//                                        }
//                                    Image(systemName: "calendar")
//                                        .font(.system(size: 14))
//
//                                        .foregroundColor(myColor.textSecondary)
//                                }
//                                .padding(.horizontal,10)
//                                .padding(.vertical,5)
//                                .background(myColor.containerColor)
//                                .cornerRadius(8)
//
//
//                            Spacer()
//
//
//
//
//
//                        }
                        if customerAccount != nil {
                            CurencyAndAccGroupShowView(curnecyName: vm.curences.first(where: {$0.curencyId == customerAccount?.curencyId})?.curencyName ?? "", accGroupName: vm.accGroups.first(where: {$0.accGroupID == customerAccount?.accGroupId})?.accGroupName ?? "")
                                .padding(.horizontal)
                                .padding(.vertical, 7)
                        }
                        
                       
                       // ReportCurencyView()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    if customerAccount != nil {
                        MovementMoenyTableHeaderView()
                    }
                   
                    ForEach(journals){ journal in
                        LazyVGrid(columns: columns) {
                            Text(Utilies.formattedDate(date: journal.registerAt ?? Date.now))
                                .font(.system(size: 11))
                                .foregroundColor(myColor.textSecondary)
                            
                           
                            Text("\(Utilies.formattedValue(using:  journal.credit))")
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .font(.body)
                            
                            Text("\(Utilies.formattedValue(using: journal.debit ))")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .font(.body)
                            
                            
                            HStack {
                                Text(journal.journalDetails ?? " ")
                                    .foregroundColor(myColor.textSecondary)
                                    .customFont(size: 12)
                            }
                            .frame(maxWidth: .infinity,alignment: .trailing)
                            .padding(.trailing)
                            
                            
                            
                        }
                        Divider()
                    }
                    
                    
                    ReportsFooterView()
                }
                .frame(maxHeight: .infinity,alignment: .top)
                .navigationBarBackButtonHidden(true)
                .sheet(isPresented: $reportsVm.showshareSheet) {
                    reportsVm.PDFUrl = nil
                } content: {
                    if let PDFUrl = reportsVm.PDFUrl {
                        ShareSheet(urls: [PDFUrl])
                    }
                }
                
            }
            if isSearchListShowing {
                VStack(spacing: 3) {
                    ForEach(searchList) { cac in
                        HStack {
                            Text(vm.curences.first(where: {$0.curencyId == cac.curencyId})?.curencySymbol ?? "")
                                .customFont(size: 12)
                                .foregroundColor(myColor.textSecondary)
                            Spacer()
                            Text(vm.accGroups.first(where: {$0.accGroupID == cac.accGroupId})?.accGroupName ?? "")
                                .customFont(size: 12)
                                .foregroundColor(myColor.textSecondary)
                            Spacer()
                            Text(vm.customers.first(where: {$0.customerId == cac.customerId})?.customerName ?? "")
                                .customFont(size: 12,bold: true)
                                .foregroundColor(myColor.textPrimary)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,7)
                        .background(myColor.bgColor.cornerRadius(10))
                        .onTapGesture {
                           
                            customerAccount = cac
                            reportsVm.curencyId = customerAccount?.curencyId
                            
                            searchText = vm.customers.first(where: {$0.customerId == cac.customerId})?.customerName ?? ""
                           
                
                            searchList.removeAll()
                            
                            
                            isSearchListShowing = false
                        }
                    }
                    
                   
                }
                
                .padding(3)
                .background(myColor.blackColor.opacity(0.6).cornerRadius(10))
                .padding(.horizontal,30)
                .offset(x:0,y:70)
            }
        }
        .onChange(of: searchText) { newValue in
            journals = []
            reportsVm.totalDebit = 0
            reportsVm.totalCredit = 0
            customerId = ""
            if newValue == "" {
                isSearchListShowing = false
            }
            let cacs = vm.customersAccount.filter { cac in
                (vm.customers.first(where: {$0.customerName!.lowercased().contains(newValue.lowercased())})?.customerId == cac.customerId)
            }
            
            
           searchList = cacs
            if !searchList.isEmpty {
                isSearchListShowing = true
            }
        }
       
        .onChange(of: customerAccount) { newValue in
            reportsVm.totalDebit = 0
            reportsVm.totalCredit = 0
            if newValue != nil {
                reportsVm.totalDebit = newValue?.totalDebit ?? 0
                reportsVm.totalCredit = newValue?.totalCredit ?? 0
                
                journals = newValue?.journals?.allObjects as? [Journal] ?? []
            }else {
                journals = []
               // customerId = ""
            }
            
        }
        .onAppear {
            reportsVm.totalDebit = 0
            reportsVm.totalCredit = 0
        }

       
    }
}

struct MovementMoneyReportView_Previews: PreviewProvider {
    static var previews: some View {
       MovementMoenyTableHeaderView()
    }
}
struct MovementMoenyTableHeaderView:View {
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 100),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
       
        GridItem(.flexible(minimum: 100, maximum: 500), spacing: 10),
       
        
    ]
    var body: some View {
        VStack {
            Divider()
            HStack {
                LazyVGrid(columns: columns) {
                 
                    Text("التأريخ")
                    Text("لة")
                    Text("علية")
                    Text("التفاصيل")
                }
                
            }
            .customFont(size: 12,bold: true)
            .padding(.vertical,5)
            Divider()
        }
    }
}
struct CurencyAndAccGroupShowView :View {
    let curnecyName:String
    let accGroupName :String
    var body: some View {
        VStack {
           
            HStack {
                Text(curnecyName)
                    .customFont(size: 12,bold: true)
                    .foregroundColor(myColor.textPrimary)
                Text("العملة :")
                    .customFont(size: 12)
                    .foregroundColor(myColor.textSecondary)
                Spacer()
                Text(accGroupName)
                    .customFont(size: 12,bold: true)
                    .foregroundColor(myColor.textPrimary)
                Text("التصنيف :")
                    .customFont(size: 12)
                    .foregroundColor(myColor.textSecondary)
                
               
            }
            .padding(.horizontal)
            .padding(.vertical,5)
           
        }
    }
}
//// MARK: Date Extension
//  extension Date{
//      func toString(_ format: String)->String{
//          let formatter = DateFormatter()
//          formatter.dateFormat = format
//          return formatter.string(from: self)
//      }
//  }
//
// // Swiftui Code
//
//  struct DatePickerView: View {
//      @Binding  var selectedDate :Date
//  let dateFormatter = DateFormatter()
//  var body: some View {
//      VStack(alignment: .leading){
//
//          HStack {
//              Text(selectedDate.toString("dd-mm-yyy"))
//                  .bold()
//                  .overlay {
//                      DatePicker(
//                          "",
//                          selection: $selectedDate,
//                          displayedComponents: .date
//                      )
//                      .blendMode(.destinationOver)
//                  }
//          }
//          .padding(.horizontal,10)
//          .padding(.vertical,10)
//          .background(Color.red.opacity(0.5))
//          .cornerRadius(8)
//
//      }
//  }
//}
