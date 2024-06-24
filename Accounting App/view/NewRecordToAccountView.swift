//
//  NewRecordToAccountView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 29/05/2023.
//

import SwiftUI

struct NewRecordToAccountView: View {
    //MARK: Properties
    @State var customerAccount:CustomerAccount
    @State private var money:String = ""
    
    @State private var currentDate:Date = Date()
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm :AccountingAppViewModel
    
  
    
    //MARK: Body
    
    var body: some View {
        
        ZStack(alignment:.top) {
            
            VStack(spacing:10) {
                VStack {
                    if let message = vm.isError {
                        
                        ErrorView(message: message)
                        
                    }
                    HStack {
                        Text( getCustomer(customerId:customerAccount.customerId ?? "")?.customerName ?? "")
                            .customFont(size: 16,bold: true)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(9)
                    .background(myColor.textSecondary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                }
                
                .padding(.top)
                
                HStack(spacing:10) {
                    
                    HStack {
                        CustomTextField(textFieldBind: $money, placeHolder: "المبلغ")
                            .keyboardType(.numberPad)
                        
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
                        
                    }
                    
                    
                    
                }
                
                HStack(spacing:10) {
                    
                    CustomTextField(textFieldBind: $vm.descTextfild, placeHolder: "التفاصيل")
                    
                    
                    
                }
                
                
                
                //               ListOfRadioButtonView()
                //                .padding(.top)
                CurencyView()
                
                HStack {
                    
                    
                    
                    
                    CustomBtn(color: Color.green, label: "له") {
                        if !money.isEmpty && !vm.descTextfild.isEmpty {
                            
                            addAccRestructionToCustomer(Credit: true)
                        }else {
                            withAnimation {
                                
                                vm.isError = MyErrorMessage.isEmpty
                            }                            }
                    }
                    
                    
                    CustomBtn(color: Color.red, label: "عليه") {
                        if !money.isEmpty && !vm.descTextfild.isEmpty  {
                            
                            addAccRestructionToCustomer(Credit: false)
                        }else {
                            withAnimation {
                                
                                vm.isError = MyErrorMessage.isEmpty
                            }
                        }
                    }
                    
                    
                    
                    
                }
                .padding(.top)
                
                Spacer()
                Spacer()
            }
            .padding()
            .onAppear {
                if vm.editedJournal != nil {
                    money = " \(Int((vm.editedJournal?.credit ?? 0) + (vm.editedJournal?.debit ?? 0)))"
                    vm.descTextfild = vm.editedJournal?.journalDetails ?? " "
                    currentDate = (vm.editedJournal?.registerAt ?? Date.now)
                    
                }else {
                    vm.descTextfild = ""
                }
                
            }
            .onChange(of: money, perform: { newValue in
                withAnimation {
                    
                    vm.isError = nil
                }
            })
            .onChange(of: vm.descTextfild, perform: { newValue in
                if newValue.count > 3 {
                    withAnimation {
                        
                        vm.isError = nil
                    }
                }
            })
            
            
            
            .environment(\.layoutDirection, .rightToLeft)
            
            
        }
        
        
        
        
    }
    
    //MARK: function
    
    func getCustomer (customerId:String) -> Customer? {
        return vm.customers.first(where: {$0.customerId == customerId})
    }
    
    func addAccRestructionToCustomer(Credit:Bool){
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        var doubleNumber = 0.0
        if let number = formatter.number(from: money)?.doubleValue {
            doubleNumber = number
        }
        if doubleNumber == 0 {
            
            return
        }
        if Credit {
            vm.credit = doubleNumber
            vm.debit = 0
        }else {
            vm.credit = 0
            vm.debit = doubleNumber
        }
        if vm.editedJournal != nil {
            vm.editedJournal?.debit = vm.debit
            vm.editedJournal?.credit = vm.credit
            vm.editedJournal?.registerAt = currentDate
            vm.editedJournal?.journalDetails = vm.descTextfild
            vm.updateJournal(journal:vm.editedJournal!, customerAccount: customerAccount)
        }else
        {
            vm.addJournal(customerAccount: customerAccount,registerAt: currentDate)
            
        }
        money = ""
        dismiss()
    }
    
    
    
    
    
    
}

//struct NewRecordToAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRecordToAccountView(customerAccount: CustomerAccount()
//            )
//        .environmentObject(AccountingAppViewModel())
//    }
//}
