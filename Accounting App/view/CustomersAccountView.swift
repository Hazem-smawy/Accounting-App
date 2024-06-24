//
//  CustomersAccountView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 23/07/2023.
//

import SwiftUI
//
//struct CustomersAccountView: View {
//    @EnvironmentObject var vm :AccountingAppViewModel
//    @State private var customerAccount:CustomerAccount? = nil
//    @State private var customersAccounts:[CustomerAccount] = []
//    @State private var customerAccountToDelete:CustomerAccount? = nil
//    @State private var isDialogOpen:Bool = false
//    @State private var customerAccountDetails:CustomerAccount? = nil
//    var width = UIScreen.main.bounds.width - 35
//
//    @Environment(\.dismiss) var dismis
//    var body: some View {
//        VStack {
//            SittingHeaderView(title:" حسابات العملاء")
//
//            if customersAccounts.isEmpty {
//                VStack {
//                    //  DrawerView()
//                    Spacer()
//                    Image(systemName: "doc.on.clipboard.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 70,height: 70)
//                        .foregroundColor(myColor.textSecondary)
//                    Text("لا يوجد اي حساب ")
//                        .foregroundColor(myColor.textSecondary)
//                        .customFont(size: 14)
//
//
//                        Text("اضف حساب")
//                            .customFont(size: 14,bold: true)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(.vertical,10)
//                            .padding(.horizontal)
//                            .frame(maxWidth: .infinity)
//                            .background(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(myColor.blackColor)
//                            )
//
//                            .onTapGesture {
//                                dismis()
//                            }
//                            .padding(.horizontal)
//                            .padding(.horizontal)
//
//
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity,maxHeight: .infinity)
//            }else {
//                List {
//                    ForEach(customersAccounts.sorted(by: {$0.accGroupId  ?? " " > $1.accGroupId ?? " "})) { cac in
//                        HStack (spacing:5){
//                            Image(systemName: "square.and.pencil")
//                                .foregroundColor(.green)
//                                .onTapGesture {
//                                    customerAccount = cac
//                                }
//                            Image(systemName: "trash")
//                                .foregroundColor(.red)
//                                .onTapGesture {
//
//                                   customerAccountToDelete = cac
//                                    isDialogOpen.toggle()
//
//
//                                }
//
//                            HStack {
//                                Image(systemName: "person")
//                                    .foregroundColor(myColor.textSecondary)
//                                Text("\(vm.customers.first(where: {$0.customerId == cac.customerId})?.customerName ?? " ")")
//                                    .customFont(size: 14)
//                                    .foregroundColor(myColor.textSecondary)
//                                    .lineLimit(1)
//                                    .frame(width: width * 0.25,alignment: .leading)
//
//                                HStack {
//                                    Image(systemName: "dollarsign.circle")
//                                        .font(.subheadline)
//
//                                    Text("\(vm.curences.first(where: {$0.curencyId == cac.curencyId})?.curencyName ?? " ")")
//
//                                        .customFont(size: 12)
//                                        .lineLimit(1)
//                                }
//                                .frame(width: width * 0.2,alignment: .leading)
//
//
//                                HStack {
//                                    Image(systemName: "folder")
//                                        .font(.subheadline)
//
//
//
//                                    Text("\(vm.accGroups.first(where: {$0.accGroupID == cac.accGroupId})?.accGroupName ?? " ")")
//                                        .customFont(size: 14)
//                                        .lineLimit(1)
//                                }
//                                .frame(width: width * 0.25,alignment: .leading)
//
//
//
//                                HStack {
//
//                                }
//                                .background {
//                                    Circle()
//                                        .fill(cac.status ? .green :.red)
//                                        .frame(width: 10,height: 10)
//
//                                }
//                                .offset(x:15)
//                            }
//                            .foregroundColor(myColor.textPrimary)
//                            //                        .frame(maxWidth: .infinity,alignment: .leading)
//                            Spacer()
//
//
//
//                        }
//                        .onTapGesture {
//                            customerAccountDetails = cac
//                        }
//
//                    }
//                }
//                .listStyle(.plain)
//
//
//
//            }
//
//        }
//        .overlay(alignment: .center, content: {
//            if isDialogOpen && customerAccountToDelete != nil {
//
//                CustomDialogView( action: {
//                    deleteCustomerAccount(cac: customerAccountToDelete!)
//                }, hideDialg: {
//                    isDialogOpen = false
//                    customerAccountToDelete = nil
//
//                },description: "سيتم حذف هذا الحساب بكل مافيه من سجلات بشكل نهائي")
//            }else {
//                EmptyView()
//            }
//
//
//        })
//        .onAppear {
//            customersAccounts = vm.customersAccount
//
//        }
//        .sheet(item: $customerAccount, onDismiss: {
//            customersAccounts = vm.customersAccount
//        }, content: { cac in
//            SelecteGroupView(accGroupId: cac.accGroupId ?? " ", customerAccount: cac)
//                .presentationDetents([.medium])
//                .presentationDragIndicator(.visible)
//                .contentShape(RoundedRectangle(cornerRadius: 20))
//        })
//        .sheet(item: $customerAccountDetails) { Identifiable in
//            CustomerAccountDetailsView(cac: $customerAccountDetails)
//                .contentShape(RoundedRectangle(cornerRadius: 30))
//                .presentationDetents([.medium])
//                .presentationDragIndicator(.visible)
//        }
//
//    }
//    func deleteCustomerAccount(cac:CustomerAccount) {
//
//        vm.deleteCusomerAccount(customerAccount: cac)
//        customersAccounts = vm.customersAccount
//        vm.snakbarMessage = "تم حذف هذا التصنيف بكل مافيه من سجلات"
//        vm.isSnackbarShowing = true
//        customerAccountToDelete = cac
//         isDialogOpen.toggle()
//    }
//}



struct SelecteGroupView:View {
    @State var accGroupId :String
    let customerAccount:CustomerAccount
    @EnvironmentObject var vm:AccountingAppViewModel
    @State private var status:Bool = false
    @Environment(\.dismiss) var dismis
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Toggle("", isOn: $status)
                        .labelsHidden()
                    Spacer()
                    Text("حاله الحساب")
                        .customFont(size: 14)
                        .fontWeight(.medium)
                        .foregroundColor(status ? myColor.primaryColor : .red)
                }
                .padding(.horizontal,5)
                //                .frame(maxWidth: .infinity)
                
                VStack {
                    ForEach(vm.accGroups,id: \.self){group in
                        HStack {
                            if group.accGroupID == accGroupId {
                                Image(systemName: "checkmark.circle")
                            }
                            Spacer()
                            Text(group.accGroupName ?? " ")
                                .customFont(size: 14)
                            Image(systemName: "folder")
                                .font(.subheadline)
                        }
                        .padding()
                        .background(myColor.containerColor)
                        .cornerRadius(12)
                        .foregroundColor( group.accGroupID == accGroupId ? Color.green : myColor.textSecondary)
                        .fontWeight( group.accGroupID == accGroupId ? .bold : .regular)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .onTapGesture {
                            if group.status && vm.accGroups.first(where: {$0.accGroupID == accGroupId})?.status ?? false
                            {
                                
                                accGroupId = group.accGroupID ?? ""
                            }else {
                                withAnimation {
                                    vm.snakbar = .init(message: "هذا الحساب موقف قم بتغير الاعدادات للتعديل", color: .red, icon: "exclamationmark.triangle.fill")
                                  
                                    vm.isSnackbarShowing = true
                                }
                            }
                            
                        }
                    }
                }
                
            }
            
            CustomBtn(color: Color.green, label:"تأكيد") {
                customerAccount.accGroupId = accGroupId
                customerAccount.status = status
                vm.saveCustomersAccount()
                dismis()
            }
            .padding(.top,20)
        }
        
        .padding()
        .padding(10)
        .onAppear {
            status = customerAccount.status
        }
    }
}


struct CustomersAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersAccountView()
            .environmentObject(AccountingAppViewModel())
    }
}

//struct GridItemDemo: View {
//
//
//    var body: some View {
//
//    }
//}


struct CustomersAccountView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @State private var customerAccount:CustomerAccount? = nil
    @State private var customersAccounts:[CustomerAccount] = []
    @State private var customerAccountToDelete:CustomerAccount? = nil
    @State private var isDialogOpen:Bool = false
    @State private var customerAccountDetails:CustomerAccount? = nil
    var width = UIScreen.main.bounds.width - 35
    
    
    @Environment(\.dismiss) var dismis
    
    let columns = [
        GridItem(.fixed(30), spacing: 2),
       // GridItem(.fixed(30), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 400), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 400), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 400), spacing: 10),
        GridItem(.fixed(20), spacing: 10),
        
    ]
    @State private var search:String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.right")
                    .foregroundColor(myColor.textSecondary)
                    .onTapGesture {
                        dismis()
                    }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(5)
                    TextField("بحث في حسابات العملاء" , text: $search)
                        .multilineTextAlignment(.leading)
                        .customFont(size: 15)
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(myColor.settingColor)
                )
               
               
                
              
                
            }
            .padding()
            
            if customersAccounts.isEmpty {
                VStack {
                    //  DrawerView()
                    Spacer()
                    Image(systemName: "doc.on.clipboard.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70,height: 70)
                        .foregroundColor(myColor.textSecondary)
                    Text("لا يوجد اي حساب ")
                        .foregroundColor(myColor.textSecondary)
                        .customFont(size: 14)
                    
                    
//                    Text("اضف حساب")
//                        .customFont(size: 14,bold: true)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(.vertical,10)
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                        .background(
//                            RoundedRectangle(cornerRadius: 12)
//                                .fill(myColor.blackColor)
//                        )
//
//                        .onTapGesture {
//                            dismis()
//                        }
//                        .padding(.horizontal)
//                        .padding(.horizontal)
//
//
                    Spacer()
                    Spacer()
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }else {
                VStack {
                    
                    
                   
                    ScrollView {
                        LazyVGrid( columns: columns, spacing: 5) {
                            
                            ForEach(customersAccounts.sorted(by: {$0.accGroupId  ?? " " > $1.accGroupId ?? " "})) { cac in
                                
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.green)
                                    .onTapGesture {
                                        customerAccountDetails = cac
                                    }
                                    .padding(.top,10)
                                
//                                Image(systemName: "trash")
//                                    .foregroundColor(.red)
//                                    .onTapGesture {
//                                        
//                                        customerAccountToDelete = cac
//                                        isDialogOpen.toggle()
//                                        
//                                        
//                                    }
//                                    .padding(.top,10)
                                HStack {
                                    Image(systemName: "person")
                                        .foregroundColor(.blue)
                                    
                                    Text("\(vm.customers.first(where: {$0.customerId == cac.customerId})?.customerName ?? " ")")
                                        .customFont(size: 14)
                                        .foregroundColor(myColor.textSecondary)
                                        .lineLimit(1)
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.top,10)
                                .onTapGesture {
                                    customerAccountDetails = cac
                                }
                                HStack {
                                    Image(systemName: "folder")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                    
                                    Text("\(vm.accGroups.first(where: {$0.accGroupID == cac.accGroupId})?.accGroupName ?? " ")")
                                        .customFont(size: 14)
                                        .lineLimit(1)
                                }
                                
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .onTapGesture {
                                    customerAccountDetails = cac
                                }
                                .padding(.top,10)
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                    
                                    Text("\(vm.curences.first(where: {$0.curencyId == cac.curencyId})?.curencyName ?? " ")")
                                    
                                        .customFont(size: 12)
                                        .lineLimit(1)
                                }
                                .padding(.top,10)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .onTapGesture {
                                    customerAccountDetails = cac
                                }
                             
                                HStack {
                                    
                                }
                                .background {
                                    Circle()
                                        .fill(cac.status ? .green :.red)
                                        .frame(width: 10,height: 10)
                                    
                                }
                                .padding(.top,10)
                                .frame(maxWidth: .infinity,alignment: .center)
                            }
                            .foregroundColor(myColor.textPrimary)
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        .padding(.horizontal)
                        
                        
                        
                    }
                }
                
                Spacer()
            }
            
        }
        .overlay(alignment: .center, content: {
            if isDialogOpen && customerAccountToDelete != nil {
                
                CustomDialogView( action: {
                    deleteCustomerAccount(cac: customerAccountToDelete!)
                }, hideDialg: {
                    isDialogOpen = false
                    customerAccountToDelete = nil
                    
                },description: "سيتم حذف هذا الحساب بكل مافيه من سجلات بشكل نهائي")
            }else {
                EmptyView()
            }
            
            
        })
        .onChange(of: search, perform: { newValue in
            if search.isEmpty {
                fetchAllCustomerAccounts()
            }else {
                let cacs = vm.customersAccount.filter { cac in
                    (vm.customers.first(where: {$0.customerName!.lowercased().contains(newValue.lowercased())})?.customerId == cac.customerId)
                }
                
                customersAccounts =  cacs.sorted{(cac0,cac1) -> Bool in
                    if cac0.accGroupId == cac1.accGroupId {
                        return cac0.customerId ?? "" > cac1.customerId ?? ""
                    }else {
                        return cac0.accGroupId ?? "" < cac1.accGroupId ?? ""
                    }
                }
            }
            
        })
        .onAppear {
           fetchAllCustomerAccounts()
            
        }
        .sheet(item: $customerAccount, onDismiss: {
            customersAccounts = vm.customersAccount
        }, content: { cac in
            SelecteGroupView(accGroupId: cac.accGroupId ?? " ", customerAccount: cac)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .contentShape(RoundedRectangle(cornerRadius: 30))
        })
        .sheet(item: $customerAccountDetails) { Identifiable in
            CustomerAccountDetailsView(cac: $customerAccountDetails)
                .contentShape(RoundedRectangle(cornerRadius: 30))
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
       
    }
    func fetchAllCustomerAccounts() {
        customersAccounts = vm.customersAccount.sorted{(cac0,cac1) -> Bool in
            if cac0.accGroupId == cac1.accGroupId {
                return cac0.customerId ?? "" > cac1.customerId ?? ""
            }else {
                return cac0.accGroupId ?? "" < cac1.accGroupId ?? ""
            }
        }
    }
    func deleteCustomerAccount(cac:CustomerAccount) {
        
        vm.deleteCusomerAccount(customerAccount: cac)
        customersAccounts = vm.customersAccount
        //vm.snakbarMessage = "تم حذف هذا التصنيف بكل مافيه من سجلات"
        vm.isSnackbarShowing = true
        customerAccountToDelete = cac
        isDialogOpen.toggle()
    }
}

