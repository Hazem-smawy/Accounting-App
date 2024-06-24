//
//  SettingCustomerView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 06/06/2023.
//

import SwiftUI

struct SettingCustomerView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @State private var optionalCustomer:Customer? = nil
    @State private var customers:[Customer] = []
    @State private var isSheetOpen:Bool = false
    @State private var isDialogOpen:Bool = false
    @State var selectedCustomerToDelete:Customer? = nil
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack (alignment: .bottomLeading){
            VStack {
                SittingHeaderView(title: "العملاء")
                if customers.isEmpty {
                    VStack {
                        
                        Spacer()
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(myColor.blackColor)
                        
                        Text("ليس هناك اي عملاء")
                            .customFont(size: 14)
                            .foregroundColor(myColor.blackColor)
                            
                        Spacer()
                        Spacer()
                    }
                    .onTapGesture {
                        isSheetOpen.toggle()
                    }
                    .frame(maxWidth: .infinity)
                    
                }else {
                    List {
                        ForEach($customers) { $customer in
                            CustomerRowView(customer: $customer, optionalCustomer: $optionalCustomer,customers: $customers, isSheetOpen: $isSheetOpen,isDialagOpen: $isDialogOpen,selectedCustomerToDelete: $selectedCustomerToDelete)
                            
                        }
                    }
                    .listStyle(.plain)
                }
            }
            
            .frame(maxHeight: .infinity)
            
            Image(systemName: "plus")
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .background(Circle().fill(myColor.primaryColor))
                .padding()
                .onTapGesture {
                    withAnimation {
                        isSheetOpen.toggle()
                    }
                }
        }
        .sheet(isPresented: $isSheetOpen, onDismiss: {
            optionalCustomer = nil
        }, content: {
            AddNewCustomerView(optionalCustomer: $optionalCustomer, customers: $customers)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .environment(\.layoutDirection, .rightToLeft)
        })
      
        .onAppear {
            customers = vm.customers
        }
        .overlay {
            if selectedCustomerToDelete != nil && isDialogOpen {
                
                CustomDialogView( action: {
                    vm.deleteCustomer(customer: selectedCustomerToDelete!)
                    customers = vm.customers
                    isDialogOpen.toggle()
                }, hideDialg: {
                    isDialogOpen = false
                    
                    
                },description: "سيتم حذف هذا الحساب بكل مافيه من سجلات بشكل نهائي")
            }
        }
//        navigationBarBackButtonHidden(true)
    }
}
//
//struct SettingCustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewCustomerView()
//    }
//}
struct AddNewCustomerView :View {
    @State private var nameTextField:String = ""
    @State private var numberTextField:String = ""
    @State private var addressTextFeild:String = ""
    @State private var customerStatus:Bool = true
    @Binding var optionalCustomer:Customer?
   
    
    @Binding var customers:[Customer]
    @EnvironmentObject var vm :AccountingAppViewModel
    @Environment(\.dismiss) var dismis
    var body: some View {
        VStack(spacing:15) {
           
            VStack {
           
                AddOrEditTitleSittingView(icon: optionalCustomer == nil ?  "person.badge.plus": "person.crop.circle.fill.badge.checkmark", title: optionalCustomer == nil ? "اضافه عميل ": "تعد يل")
                if let message = vm.isError {
                    
                    ErrorView(message: message)
                  
                }
                Toggle("حالة العميل", isOn: $customerStatus)
                    .customFont(size: 12)
            }
            .foregroundColor(myColor.textSecondary)
            
            HStack {
                CustomTextField(textFieldBind: $nameTextField, placeHolder: "اسم العميل")
                CustomTextField(textFieldBind: $numberTextField, placeHolder: "الرقم")
               
                
            }
            CustomTextField(textFieldBind: $addressTextFeild, placeHolder: "العنوان")
            
            CustomBtn(color: myColor.primaryColor, label: optionalCustomer == nil ? MoreWordUsed.add:MoreWordUsed.edit) {
                if nameTextField.count > 2  {
                    if numberTextField.isEmpty {
                        numberTextField = "xxxxxxxx"
                        
                    }
                    if addressTextFeild.isEmpty {
                        addressTextFeild = "لا يوجد عنوان"
                        
                    }
                    addOrUpdateCustomers()
                }else {
                    vm.isError = MyErrorMessage.isEmpty
                }
            }
        }
        .onChange(of: nameTextField, perform: { newValue in
            withAnimation {
                
                vm.isError = nil
            }
        })
        .padding()
        .onAppear {
            if optionalCustomer != nil {
                nameTextField = optionalCustomer?.customerName ?? ""
                numberTextField = optionalCustomer?.phone ?? ""
                addressTextFeild = optionalCustomer?.address ?? ""
                customerStatus = optionalCustomer?.status ?? customerStatus
            }
        }
        
        
    }
    
    func addOrUpdateCustomers() {
        
        if optionalCustomer != nil {
            if customers.filter({$0.customerName == nameTextField}).count > 1 {
                withAnimation {
                    
                    vm.isError = MyErrorMessage.exit
                }
                return
            }
            vm.updateCustomer(customer: optionalCustomer!, name: nameTextField, number: numberTextField, address: addressTextFeild, status: customerStatus)
            optionalCustomer = nil
        }else {
            if customers.contains(where: {$0.customerName == nameTextField}) {
                withAnimation {
                    
                    vm.isError = MyErrorMessage.exit
                }
                return
            }
            vm.addCustomer(name: nameTextField, number: numberTextField, address: addressTextFeild, status: customerStatus)
        }
        
        customers = vm.customers
        dismis()
    }
}
struct CustomerRowView:View {
    @Binding var customer:Customer
    @Binding var optionalCustomer:Customer?
    @EnvironmentObject var vm:AccountingAppViewModel
    @Binding var customers:[Customer]
    @Binding var isSheetOpen:Bool
    @Binding var isDialagOpen:Bool
    @Binding var selectedCustomerToDelete:Customer?
    
    var body: some View {
        VStack(spacing:5) {
            
            
            HStack (spacing:10){
                
                
                
                
                
                Image(systemName: "person")
                Text(customer.customerName ?? "")
                    .customFont(size: 14,bold: true)
                Spacer()
                Circle()
                    .fill(customer.status ? .green : .red)
                    .frame(width: 15,height: 15)
                
            }
           // .font(.title2)
            .padding(.bottom,10)
            
            HStack(spacing:10) {
                
                Image(systemName: "phone")
                Text(customer.phone ?? "")
                    
                Spacer()
                
            }
            .customFont(size: 12)
          
            HStack(spacing:10) {
                Image(systemName: "location")
                Text(customer.address ?? "")
                   
                
                Spacer()
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .onTapGesture {
                        isDialagOpen.toggle()
                        selectedCustomerToDelete = customer
                    }
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .onTapGesture {
                        
                        optionalCustomer = customer
                        isSheetOpen.toggle()
                    }
                
            }
            .customFont(size: 12)
            
            
            
            
        }
        .padding()
        .background(myColor.containerColor.cornerRadius(10))
        .customShadow()
       
    }
}
