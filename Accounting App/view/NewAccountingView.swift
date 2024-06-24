//
//  NewAccountingView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 25/05/2023.


import SwiftUI

struct NewAccountingView: View {
    
    
    @State private var moneyTextfiled:String = ""
    
    @EnvironmentObject var vm :AccountingAppViewModel
    @Environment(\.dismiss) var dismiss
    @State private var fromCustomer :[Customer] = []
    @State private var selectedCustomer:Customer? = nil
    @State private var isPresented:Bool = false
    @State private var currentDate:Date = Date()
    @State private var allCustomers:[Customer] = []
    @State private var customerAccount:CustomerAccount?
    
    @State private var journals:[Journal] = []
    @State private var reversedJournals:[Journal] = []
    @Binding var accGroup:AccGroup
    @Binding var curency:Curency
    
    
    var body: some View {
        ZStack(alignment:.top) {
            
            
            
            
            
            VStack(spacing:10) {
                //MARK: error
                if let message = vm.isError {
                    
                    ErrorView(message: message)
                    
                }
                HStack(spacing:10) {
                    
                    
                    CustomTextField(textFieldBind: $vm.nameTextfild, placeHolder: "الاسم")
                    
                    CustomTextField(textFieldBind: $moneyTextfiled, placeHolder: "المبلغ" )
                        .keyboardType(.numberPad)
                    
                    
                }
                
                HStack(spacing:10) {
                    
                    
                    CustomTextField(textFieldBind: $vm.descTextfild, placeHolder: "التفاصيل")
                    
                    
                    
                        HStack {
                            Image(systemName: "calendar")
                                .font(.body)
                                .foregroundColor(myColor.textSecondary)
                            Text(Utilies.formattedDate(date: currentDate))
                                .font(.body)
                                .foregroundColor(myColor.textSecondary)
                                .overlay {
                                    DatePicker(
                                        "",
                                        selection: $currentDate,
                                        displayedComponents: .date
                                    )
                                    .blendMode(.destinationOver)
                                }
                          
                        }
                        .padding(13)
                        .background(.thickMaterial)
                        .cornerRadius(10)
//                        .background(myColor.containerColor)
//                        .cornerRadius(8)
                    
//                    DatePicker("title", selection: $currentDate ,displayedComponents: .date)
//                        .foregroundColor(.white)
//                        .datePickerStyle(.automatic)
//                        .labelsHidden()
//                        .padding(5.5)
//                        .background(myColor.textSecondary.opacity(0.5))
//                        .cornerRadius(10)
//                        .foregroundColor(Color.white)
                }
                .overlay(alignment: .topLeading) {
                    
                    VStack {
                        ForEach(fromCustomer) { customer in
                            VStack(alignment:.leading) {
                                HStack {
                                    Text(customer.customerName ?? "")
                                        .multilineTextAlignment(.leading)
                                        .padding(5)
                                        .customFont(size: 12)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                    
                                    
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .shadow(color: myColor.shadowColor, radius: 10)
                                
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .onTapGesture {
                                selectedCustomer = customer
                                getCustomerAccount()
                                vm.nameTextfild = selectedCustomer?.customerName ?? ""
                                
                                
                                fromCustomer.removeAll()
                            }
                        }
                    }
                    .padding(4)
                    .background( .thinMaterial )
                    .cornerRadius(10)
                    .foregroundColor(myColor.textSecondary)
                    .opacity(fromCustomer.count > 0 ? 1 : 0)
                    .zIndex(2)
                    .overlay(alignment: .topTrailing) {
                        Image(systemName: "xmark")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .padding(5)
                            .background(
                                Circle()
                                    .fill(.white)
                            )
                            .offset(x:7,y:-7)
                            .onTapGesture {
                                fromCustomer.removeAll()
                            }
                            .shadow(color: myColor.shadowColor, radius: 10)
                            .opacity(fromCustomer.count > 0 ? 1:0)
                        
                    }
                    
                }
                .zIndex(2)
                
                ListOfRadioButtonView()
                    .onChange(of: vm.currentCurency, perform: { newValue in
                        getCustomerAccount()
                    })
                    .padding(.top)
                
                
                
                HStack {
                    CustomBtn(color: Color.green, label: "له") {
                        
                        if !vm.nameTextfild.isEmpty && !moneyTextfiled.isEmpty && !vm.descTextfild.isEmpty {
                            
                            addNewCustomerWithAccRestruction(credit: true)
                            
                        }else {
                            withAnimation {
                                
                                vm.isError = MyErrorMessage.isEmpty
                            }
                        }
                        
                        
                    }
                    
                    
                    CustomBtn(color: Color.red, label: "عليه") {
                        
                        
                        if !vm.nameTextfild.isEmpty && !moneyTextfiled.isEmpty && !vm.descTextfild.isEmpty {
                            
                            
                            addNewCustomerWithAccRestruction(credit: false)
                            
                        }else {
                            withAnimation {
                                
                                vm.isError = MyErrorMessage.isEmpty
                            }
                            
                        }
                    }
                    
                    
                    
                }
                .padding(.top)
                
                VStack {
                    List {
                        ForEach(Array(journals.enumerated()),id: \.element.id ) { (i,journal)  in
                            HStack {
                                
                                AccountDetailRowView(journal: journal, accountingMoneyResult: getAccountMoney(index: i))
                            }
                        }
                    }
                    .listStyle(.plain)
                    //.padding(.horizontal)
                }
                
                
                
            }
            .padding()
            .padding(.top)
            
        }
        .onDisappear {
            vm.nameTextfild = ""
            vm.descTextfild = ""
            vm.credit = 0
            vm.debit = 0
            vm.isError = nil
        }
        .onChange(of: moneyTextfiled, perform: { newValue in
            if !fromCustomer.isEmpty {
                fromCustomer.removeAll()
            }
            if vm.isError != nil {
                withAnimation {
                    
                    vm.isError = nil
                }
            }
        })
        .onChange(of: vm.nameTextfild) { newValue in
            withAnimation {
                
                vm.isError = nil
            }
            if selectedCustomer != nil && selectedCustomer?.customerName == newValue{
                fromCustomer.removeAll()
                
            }else {
                // accRestrictionForCustomer.removeAll()
                fromCustomer.removeAll()
                journals.removeAll()
                reversedJournals.removeAll()
                let findedCustomers = allCustomers.filter { customer in
                    customer.customerName?.contains(newValue) ?? false
                }
                
                
                fromCustomer = findedCustomers
                selectedCustomer = nil
            }
            
            
            
            
            
            
        }
        
        
        .sheet(isPresented:$isPresented, onDismiss: {
            allCustomers = vm.customers
            vm.descTextfild = ""
            moneyTextfiled = ""
            dismiss()
            
        }, content: {
            NewAccRestructinToNewCustomer(currentDate: $currentDate, accGroup: $accGroup, curency: $curency)
                .environment(\.layoutDirection, .rightToLeft)
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
                .interactiveDismissDisabled()
                .contentShape(RoundedRectangle(cornerRadius: 50))
        })
        .onAppear {
            if !vm.customers.isEmpty {
                allCustomers = vm.customers
            }
        }
        
        
        
        
        
    }
    func getAccountMoney(index:Int) -> Double {
        
        var result:Double = 0
        
        for i in stride(from: reversedJournals.count - 1  - index, to: -1, by: -1) {
            result += reversedJournals[i].credit > 0 ? reversedJournals[i].credit : -reversedJournals[i].debit
        }
        
        return result
    }
    func getCustomerAccount() {
        let res = vm.customersAccount.first { cac in
            cac.customerId == selectedCustomer?.customerId &&
            cac.accGroupId == vm.currentAccGroup?.accGroupID &&
            cac.curencyId == vm.currentCurency?.curencyId
        }
        let newJournals = res?.journals?.allObjects as? [Journal] ?? []
        journals = newJournals.sorted(by: {$0.createdAt ?? Date.now > $1.createdAt ?? Date.now})
        reversedJournals = journals.reversed()
        
    }
    func addNewCustomerWithAccRestruction(credit:Bool) {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        var doubleNumber = 0.0
        if let number = formatter.number(from: moneyTextfiled)?.doubleValue {
            doubleNumber = number
        }
        if doubleNumber == 0.0 {
            // errorMessage = "invalid input"
            withAnimation {
                
                vm.isError = MyErrorMessage.invalidInput
            }
            return
        }
        
        if credit {
            vm.credit = doubleNumber
            vm.debit = 0
        }else {
            vm.credit = 0
            vm.debit = doubleNumber
        }
        
        if vm.currentCurency == nil || !(vm.currentCurency?.status ?? false) {
            withAnimation {
                
                vm.isError = " لم تقم باختيار العمله"
            }
           
            return
        }
        
       
       
        
        if selectedCustomer != nil {
            if !getCustomerAccountStatus(customerId: selectedCustomer?.customerId ?? "") {
                withAnimation {
                    vm.statusNotification = true
                }
                dismiss()
                return
            }
            vm.addCustomersAccount(accGroup: accGroup,registerAt: currentDate)
            moneyTextfiled = ""
            vm.descTextfild  = ""
            
            getCustomerAccount()
        }else {
            
            if allCustomers.contains(where: {$0.customerName == vm.nameTextfild }) {
                
                selectedCustomer = allCustomers.first(where: {$0.customerName == vm.nameTextfild })
                if !getCustomerAccountStatus(customerId: selectedCustomer?.customerId ?? "") {
                    withAnimation {
                        vm.statusNotification = true
                    }
                    dismiss()
                    return
                }
                vm.addCustomersAccount(accGroup: accGroup, registerAt: currentDate    )
                moneyTextfiled = ""
                vm.descTextfild  = ""
                
                getCustomerAccount()
            }else {
                
                isPresented.toggle()
            }
            
        }
        allCustomers = vm.customers
        
        
    }
    
    func getCustomerAccountStatus(customerId:String)-> Bool {
        
        let currentCac = vm.customersAccount.first { cac in
            cac.curencyId == vm.currentCurency?.curencyId && cac.accGroupId == vm.currentAccGroup?.accGroupID && cac.customerId == customerId
        }
        
        return currentCac?.status ?? true
    }
    
}




struct NewAccRestructinToNewCustomer:View {
    @EnvironmentObject var vm:AccountingAppViewModel
    @Binding var currentDate :Date
    @Environment(\.dismiss) var dismis
    @Binding var accGroup:AccGroup
    @Binding var curency:Curency
    
    var body: some View {
        NavigationView {
            VStack(spacing:10) {
                AddOrEditTitleSittingView(icon:  "person.badge.plus", title: "اضافه عميل ")
                CustomTextField(textFieldBind: $vm.phone, placeHolder: "الرقم")
                CustomTextField(textFieldBind: $vm.address, placeHolder: "العنوان")
                
                HStack {
                    CustomBtn(color: myColor.primaryColor, label:MoreWordUsed.add) {
                        vm.addCustomersAccount(accGroup: accGroup, registerAt: currentDate)
                        dismis()
                    }
                    CustomBtn(color: myColor.textSecondary, label: "الغاء") {
                        dismis()
                        
                    }
                }
                .padding(.top)
                
            }
            .padding()
            .padding(5)
            
        }
        
    }
    
   
}
