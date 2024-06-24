//
//  AccountDetailsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 29/05/2023.
//

import SwiftUI
import CoreData

struct AccountDetailsView: View {
    
    var width = UIScreen.main.bounds.width - 35
    @EnvironmentObject var vm :AccountingAppViewModel
    var customerAccount:CustomerAccount
    
    @State private var  isAddDetialOpen:Bool = false
    @State private var isPresented:Bool = false
    @State private var forHem:String = ""
    @State private var onHem:String = ""
    @State private var moneySummary:String = ""
    @State private var onHmeOrForHem:Bool = false
    @Environment(\.managedObjectContext) var ctx
    @State private var journals:[Journal] = []
    @State private var detailsRow:[Journal] = []
    @State private var selectedJournals:Journal? = nil
    @State private var isLocked:Bool = false
    
    var detailsStatus :Bool {
//        print("cac :\(customerAccount.status) , acc:\(vm.currentAccGroup?.status ), curency: \(vm.currentCurency?.status)")
        return customerAccount.status && (vm.currentCurency?.status ?? true) && (vm.currentAccGroup?.status ?? true)
    }
    
    
    var body: some View {
        
        ZStack {
            
            
            VStack {
                SittingHeaderView(title: "\(vm.customers.first(where: {$0.customerId == customerAccount.customerId})?.customerName ?? " ")")
                VStack {
                    HStack {
                        
                        
                        Text("التاريخ")
                            .frame(width: width * 0.25)
                        Text("المبلغ")
                            .frame(width: width * 0.2)
                        
                        
                        Text("تفاصيل")
                            .frame(width: width * 0.3)
                        
                        
                        Image(systemName: "chevron.compact.up" )
                            .font(.title2)
                            .frame(width: width * 0.05)
                            .foregroundColor(.white)
                            .padding(3)
                        
                        Text("الحساب")
                        
                            .frame(width: width * 0.2)
                            .multilineTextAlignment(.center)
                    }
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    
                    .foregroundColor(.white)
                    .customFont(size: 14,bold: true)
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(myColor.blackColor)
                    if journals.isEmpty {
                        Spacer()
                        Image(systemName: "calendar.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                            .foregroundColor(myColor.textSecondary)
                        Text("تم حذف جميع السجلات من هذا الحساب")
                            .customFont(size: 14)
                            .foregroundColor(myColor.textSecondary)
                    }else {
                        
                        List {
                            ForEach(Array(journals.enumerated()),id: \.element) { (index,journal) in
                                
                                AccountDetailRowView(journal: journal, accountingMoneyResult: getAccountMoney(index:index ))
                                    .onTapGesture {
                                        selectedJournals = journal
                                    }
                                
                                
                            }
                            //.onDelete { i in
                               // var index = i.first
//                                guard let index = index  else {
//                                    return
//                                }
//                                let currentJournal = journals[index]
//                                journals.remove(at: index)
//                                vm.deleteJournal(journal: currentJournal, customerAccount: customerAccount)
//                                fetchCurrentJournals()
                           // }
                            
                            
                        }
                        .listStyle(.plain)
                        //.padding(.horizontal)
                        
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
                
                VStack {
                    HStack(spacing:10) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 12,height: 12)
                            .font(.title)
                            .foregroundColor(.green)
                        Text("له  :")
                            .foregroundColor(.gray)
                        Text(forHem)
                        Spacer()
                        Image(systemName: "arrow.down")
                            .resizable()
                            .frame(width: 12,height: 12)
                            .font(.title)
                            .foregroundColor(.red)
                        Text("عليه :")
                            .foregroundColor(.gray)
                        Text(onHem)
                        
                    }
                    .customFont(size: 14)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.vertical,7)
                    .background(myColor.bgColor)
                    .cornerRadius(8)
                    
                    
                    
                    
                    
                    
                    
                    HStack {
                        HStack {
                            
                            
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(detailsStatus ? myColor.primaryColor : .secondary)
                                )
                                .onTapGesture {
                                    if detailsStatus {
                                        isPresented.toggle()
                                        
                                    }else {
                                        
                                        vm.isSnackbarShowing = true
                                        vm.snakbar = .init(message: "هذا الحساب موقف للإ ضافه قم بتغير الاعدادات", color: .red, icon: "lock.doc")
                                        isLocked.toggle()
                                       
                                    }
                                }
                            
                        }
                        .frame(width: 150,alignment: .leading)
                        
                        Spacer()
                        
                        Text(onHmeOrForHem ? "عليه ":"له :")
                            .customFont(size: 12)
                        Text(moneySummary)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        HStack {
                            Text(vm.currentCurency?.curencyName ?? " ")
                                .foregroundColor(myColor.textSecondary)
                                .customFont(size: 12,bold: true)
                            Divider()
                                .frame( width: 2,height: 15)
                            
                                .background(myColor.containerColor)
                                .foregroundColor(myColor.containerColor)
                            Text(vm.currentCurency?.curencySymbol ?? " ")
                                .customFont(size: 12,bold: true)
                                .foregroundColor(myColor.textSecondary)
                            
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical,5)
                        
                        .frame(width: 150,alignment: .center)
                        .background(
                            myColor.containerColor.cornerRadius(10)
                        )
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .customFont(size: 14)
                    .padding(3)
                    .background(myColor.bgColor)
                    .cornerRadius(12)
                    
                    
                    
                }
                
                
                
                .padding(.horizontal)
                
                
            }
            .background(myColor.containerColor)
            .onAppear {
                fetchCurrentJournals()
                
            }
            
            .navigationTitle( "")
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isPresented, onDismiss: {
                vm.descTextfild = ""
                vm.fetchCustomersAccount()
                vm.editedJournal = nil
                fetchCurrentJournals()
                
            }, content: {
                NewRecordToAccountView(customerAccount: customerAccount)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(Visibility.visible)
            })
            
            
            
        }
       
        //        .background(Color.black.ignoresSafeArea())
        .overlay (alignment:.center) {
            
            if selectedJournals != nil {
                ZStack {
                    SubDetailsView(selectedJournals: $selectedJournals, customerAccount: customerAccount,isPresented: $isPresented)
                        .environment(\.layoutDirection, .leftToRight)
                        .padding()
                        .background(myColor.bgColor.cornerRadius(20))
                        .customShadow()
                        .padding(.vertical,100)
                        .padding(.horizontal,50)
                        .zIndex(200)
                        .scaleEffect(selectedJournals != nil ? 1 : 0.5)
                        .opacity(selectedJournals != nil ? 1 : 0.5)
                        .animation(.easeInOut, value: selectedJournals != nil)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(myColor.textSecondary.opacity(0.7).ignoresSafeArea())
                .zIndex(100)
                .onTapGesture {
                    withAnimation {
                        selectedJournals = nil
                        
                    }
                }
                
            }else {
                EmptyView()
            }
        }
       
        

        
        
        
        
    }
    func fetchCurrentJournals() {
        let newJournals = customerAccount.journals?.allObjects as? [Journal] ?? []
        journals = newJournals.sorted(by: {$0.createdAt ?? Date.now > $1.createdAt ?? Date.now})
        detailsRow = journals.reversed()
        getSummeryMoney()
    }
    
    func getAccountMoney(index:Int) -> Double {
        
        var result:Double = 0
        
        for i in stride(from: detailsRow.count - 1  - index, to: -1, by: -1) {
            result += detailsRow[i].credit > 0 ? detailsRow[i].credit : -detailsRow[i].debit
        }
        
        
        
        return result
    }
    func getSummeryMoney() {
        var onHemNumber:Double = 0.0
        var forHemNumber:Double = 0.0
        var resMoney:Double = 0.0
        
        detailsRow.forEach { row in
            forHemNumber += row.credit
            onHemNumber += row.debit
        }
        resMoney = forHemNumber - onHemNumber
        onHmeOrForHem = resMoney < 0 
        
        onHem = Utilies.formattedValue(using: onHemNumber)
        forHem = Utilies.formattedValue(using: forHemNumber)
        moneySummary = Utilies.formattedValue(using:abs( resMoney))
    }
}


// MARK: row view

struct AccountDetailRowView :View {
    var journal:Journal
    var width = UIScreen.main.bounds.width - 35
    var accountingMoneyResult:Double
    
    
    @EnvironmentObject var vm:AccountingAppViewModel
    
    var body: some View {
        HStack(alignment:.center) {
            VStack(spacing:0) {
                Text(Utilies.formattedDate(date: journal.registerAt ?? Date.now))
                    .customFont(size: 12,bold: true)
                
            }
            .foregroundColor(myColor.textPrimary.opacity(0.7))
            .frame(width:width * 0.25)
            
            Text("\(Utilies.formattedValue(using: abs(journal.credit - journal.debit)))")
                .frame(width:width * 0.2)
                .foregroundColor(myColor.textPrimary)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(journal.journalDetails ?? " ")
                .frame(width:width * 0.3 )
                .customFont(size: 14)
                .lineLimit(1)
            
            
            Image(systemName:journal.credit > journal.debit ? "chevron.compact.up" :"chevron.compact.down")
                .frame(width:width * 0.05)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(journal.credit > journal.debit ? .green : .red)
            
            
            Text("\(Utilies.formattedValue(using:abs( accountingMoneyResult)))")
                .frame(width:width * 0.2)
                .foregroundColor(myColor.textPrimary)
                .font(.subheadline)
                .fontWeight(.medium)
            
        }
        
        .foregroundColor(myColor.textSecondary)
        .multilineTextAlignment(.center)
        
        
        
    }
}


