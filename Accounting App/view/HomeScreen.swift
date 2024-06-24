//
//  HomeScreen.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 18/07/2023.
//

import SwiftUI

struct HomeScreen: View {
    var width = UIScreen.main.bounds.width - 30
    @State private var isPresented : Bool = false
    
    @EnvironmentObject var vm:AccountingAppViewModel
    @Binding var customerAccounts:[CustomerAccount]
    @State private var selectedCustomerAccount:CustomerAccount? = nil
    
    func getCustomer (customerId:String) -> Customer? {
       return vm.customers.first(where: {$0.customerId == customerId})
    }
   
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
//            if !customerAccounts.isEmpty {
                VStack(spacing:15) {
                       
                        List {
                            
                            ForEach(customerAccounts){ cac in
                                NavigationLink {
                                    AccountDetailsView(customerAccount: cac)
                                } label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: cac.status ?  "plus" : "lock.doc")
                                            .frame(width: width * 0.05)
                                            .foregroundColor(   (vm.currentCurency?.status ?? true && vm.currentAccGroup?.status ?? true && cac.status) ? myColor.textPrimary :myColor.textSecondary)
                                            .fontWeight(.bold)
                                            .offset(x:-7)
                                            .onTapGesture {
                                                if  (vm.currentCurency?.status ?? true && vm.currentAccGroup?.status ?? true && cac.status) {
                                                    
                                                    selectedCustomerAccount = cac
                                                }else {
                                                    vm.statusNotification = true
                                                }
                                            }
//                                            .opacity((vm.currentCurency?.status ?? true && vm.currentAccGroup?.status ?? true) ? 0 : 0)
                                        
                                        
                                        
                                        
                                        
                                        HStack {
                                            Text( getCustomer(customerId: cac.customerId ?? "")?.customerName ?? " ")
                                                .customFont(size: 14,bold: true)
                                                .foregroundColor(myColor.textSecondary)
                                            
                                            
                                            // .frame(width: width * 0.4)
                                        }
                                        .frame(width: width * 0.4, alignment: .leading)
                                        
                                        
                                        Text("\(cac.operationNum )")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(6)
                                            .background(Circle()
                                                .fill(myColor.blackColor.opacity(0.9)))
                                            .frame(width: width * 0.1)
                                            .fontDesign(.rounded)
                                        
                                        
                                        Text("\(Utilies.formattedValue(using: abs(cac.totalCredit - cac.totalDebit)) )")
                                            .foregroundColor(myColor.textPrimary)
                                            .font(.headline)
                                            .frame(width: width * 0.2)
                                        
                                        Image(systemName: cac.totalCredit > cac.totalDebit ? "chevron.compact.up" :"chevron.compact.down")
                                            .font(.title2)
                                            .foregroundColor(cac.totalCredit > cac.totalDebit ? Color.green : Color.red)
                                            .frame(width: width * 0.05)
                                            .fontWeight(.bold)
                                        
                                        
                                    }
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .opacity(cac.status ? 1 : 0.6)
                                    .scaleEffect(cac.status ? 1 :0.9)
//
                                }

                                
                             
                                
                            }
                            .padding(.horizontal,2)
//                            .background{(vm.currentCurency?.status ?? true ) && (vm.currentAccGroup?.status ?? true) ? (myColor.bgColor)  : 
//                                (Color.secondary.opacity(0.3) )
//                                
//                            }
                            .cornerRadius(5)
                            
                            
                            
                            
                            //
                        }
                        
                        .listStyle(.plain)
//                        .listRowBackground(Color.secondary)
//                        .background(  myColor.containerColor.ignoresSafeArea() )
//                    
                        .padding(.top,0)
                        .environment(\.layoutDirection, .rightToLeft)
                }
//            } else {
//                VStack {
//
//                    Spacer()
//                    Image(systemName: "person.badge.plus")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 70, height: 70)
//                        .foregroundColor(myColor.blackColor)
//
//                    Text("ليس هناك اي حسابات في هذا التصنيف")
//                        .customFont(size: 14)
//                        .foregroundColor(myColor.blackColor)
//
//                    Spacer()
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity)
//
//            }
            
            
        }
        
        .background(myColor.containerColor)
        .sheet(item: $selectedCustomerAccount) { selectedCustomer in
            NewRecordToAccountView(customerAccount: selectedCustomer)
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .presentationDetents([.medium])
                .presentationDragIndicator(Visibility.visible)
        }
               
    }
        
}
