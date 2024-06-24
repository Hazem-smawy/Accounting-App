////
////  HomeView.swift
////  Accounting App
////
////  Created by B-ALDUAIS on 29/05/2023.
////
//
//import SwiftUI
//
//struct HomeView: View {
//    
//    var width = UIScreen.main.bounds.width - 30
//    @EnvironmentObject var vm:AccountingAppViewModel
//    @State private var selectedCustomer:Customer? = nil
//    @State private var accountResultMoney:Double = 0.0
//    @State private var isGroupEmpty:Bool = true
//    func getCustomerInfo(customerId:Int32)->Customer {
//        return vm.customers.first { customer in
//            customer.customerId == customerId
//        } ?? Customer(context: vm.manager.context)
//    }
//    
//   
//    var body: some View {
//        
//        VStack {
//            
//            
//                VStack {
//                    if !isGroupEmpty {
//                        VStack(spacing: 10) {
//                            Image(systemName: "person.crop.circle.badge.plus")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100,height: 100)
//                                .foregroundColor(myColor.primaryColor.opacity(0.7))
//                            Text("no content yet add some records")
//                                .font(.subheadline)
//                                .foregroundColor(myColor.textSecondary)
//                        }
//                        .padding()
//                        .opacity(isGroupEmpty ? 1 : 0)
//                        .animation(Animation.easeIn(duration: 1), value: isGroupEmpty)
//                    }else {
//                    List {
////                        ForEach(groupedAccRestriction.keys.sorted(by:  {$0 > $1}),id: \.self){item in
////                            
////                            if let myValues = vm.groupedEntities[item]  {
////                                NavigationLink {
////                                    AccountDetailsView(detailsRow: myValues)
////                                } label: {
////                                    
////                                    HStack() {
////                                        
////                                        Image(systemName: "plus")
////                                            .frame(width: width * 0.05)
////                                            .foregroundColor(myColor.textPrimary)
////                                            .fontWeight(.bold)
////                                            .offset(x:-7)
////                                            .onTapGesture {
////                                                selectedCustomer = getCustomerInfo(customerId: item)
////                                            }
////                                        
////                                        
////                                        
////                                        
////                                        HStack {
////                                            Text(getCustomerInfo(customerId:item).customerName ?? "")
////                                                .customFont(size: 14,bold: true)
////                                                .foregroundColor(myColor.textSecondary)
////                                            
////                                            
////                                           // .frame(width: width * 0.4)
////                                        }
////                                        .frame(width: width * 0.4, alignment: .leading)
////                                        
////                                        
////                                        Text("\(myValues.count)")
////                                            .font(.subheadline)
////                                            .foregroundColor(.white)
////                                            .fontWeight(.bold)
////                                            .padding(6)
////                                            .background(Circle()
////                                                .fill(myColor.blackColor.opacity(0.9)))
////                                            .frame(width: width * 0.1)
////                                            .fontDesign(.rounded)
////                                        
////                                        
////                                        Text("\(abs(getAccountMoney(accRestriction: myValues)))")
////                                            .foregroundColor(myColor.textPrimary)
////                                            .frame(width: width * 0.2)
////                                        
////                                        Image(systemName:getAccountMoney(accRestriction: myValues) > 0 ? "chevron.compact.up" :"chevron.compact.down")
////                                            .font(.title2)
////                                            .foregroundColor(getAccountMoney(accRestriction: myValues) > 0 ? Color.green : Color.red)
////                                            .frame(width: width * 0.05)
////                                        
////                                        
////                                    }
////                                    .multilineTextAlignment(.center)
////                                    .padding(.horizontal)
////                                    
////                                }
////                                
////                            }
////                            
////                        }
////                        
//                    }
//                    .listStyle(.plain)
//                }
//            }
//        }
//
//        
////        .sheet(item:$selectedCustomer ) { row in
////            NewRecordToAccountView(customer: row, isPresented: $selectedCustomer)
////        }
//        
//       
////        .onChange(of: vm.groupedEntities, perform: { newValue in
////            groupedAccRestriction.removeAll()
////            groupedAccRestriction = newValue
////
////
////
////        })
////        .onAppear {
////            groupedAccRestriction = vm.groupedEntities
////        }
//        
//        .environment(\.layoutDirection, .rightToLeft)
//        .environment(\.editMode, vm.editModeOpen ? .constant(.active ) : .constant(.inactive))
//    }
//    
//    
//    
//    
//    
//}
//
////struct HomeView_Previews: PreviewProvider {
////    static var previews: some View {
////        HomeView()
////            .environmentObject(AccountingAppViewModel())
////    }
////}
//
//struct HomeViewRowView:View {
//    @State var customer:Customer
//    @State var operation:Int
//    @State var accountMoney:Int
//    @Binding var selectedCustomer:Customer?
//    
//    var width = UIScreen.main.bounds.width - 30
//    var body: some View {
//        HStack() {
//                HStack
//            {
//                
//                Image(systemName: "plus")
//                  
//                    .onTapGesture {
//                        selectedCustomer = customer
//                    }
//            }
//            .frame(width: width * 0.05,alignment: .leading)
//                     
//
//
//
//            Text(customer.customerName ?? "")
//                      .customFont(size: 14,bold: true)
//                      .foregroundColor(myColor.textSecondary)
//
//
//                      .frame(width: width * 0.4)
//
//
//                  Text("\(operation)")
//                      .font(.subheadline)
//                      .foregroundColor(.white)
//                      .fontWeight(.bold)
//                      .padding(6)
//                      .background(Circle()
//                          .fill(myColor.blackColor.opacity(0.5)))
//                      .frame(width: width * 0.1)
//                      .fontDesign(.rounded)
//
//
//                  Text("\(accountMoney)")
//                      .foregroundColor(myColor.textPrimary)
//                      .frame(width: width * 0.2)
//
//                  Image(systemName:accountMoney < 0 ? "chevron.compact.up" :"chevron.compact.down")
//                      .font(.title2)
//                      .foregroundColor(accountMoney < 0 ? Color.green : Color.red)
//                      .frame(width: width * 0.05)
//
//
//              }
//              .multilineTextAlignment(.center)
//              .padding(.horizontal)
//
//              }
//
//}
////VStack {
////            if !vm.accounts.isEmpty {
////                List(selection: $selectedRows) {
////                    ForEach(vm.accounts, id: \.name) { row in
////                        NavigationLink {
////                            AccountDetailsView(row: row)
////                        } label: {
////                            
////                            
////                            HStack() {
////                                
////                                Image(systemName: "plus")
////                                    .frame(width: width * 0.05)
////                                    .onTapGesture {
////                                        slecectedRow = row
////                                        //showSheet.toggle()
////                                    }
////                               
////                                
////                                
////                                Text(row.name ?? " ")
////                                    .customFont(size: 14,bold: true)
////                                    .foregroundColor(myColor.textSecondary)
////                                
////                                
////                                    .frame(width: width * 0.4)
////                            
////                                
////                                Text("\(row.operation)")
////                                    .font(.subheadline)
////                                    .foregroundColor(.white)
////                                    .fontWeight(.bold)
////                                    .padding(6)
////                                    .background(Circle()
////                                        .fill(myColor.blackColor.opacity(0.5)))
////                                    .frame(width: width * 0.1)
////                                    .fontDesign(.rounded)
////                                
////                               
////                                Text("\(Int(row.money))")
////                                    .foregroundColor(myColor.textPrimary)
////                                    .frame(width: width * 0.2)
////                                
////                                Image(systemName:row.forHem ? "chevron.compact.up" :"chevron.compact.down")
////                                    .font(.title2)
////                                    .foregroundColor(row.forHem ? Color.green : Color.red)
////                                    .frame(width: width * 0.05)
////                                
////                                
////                            }
////                            .multilineTextAlignment(.center)
////                            .padding(.horizontal)
////                            
////                        }
////                        
////                    }
////                    .onDelete (perform: vm.deleteAccount(indexSet:))
////                }
////                .listStyle(.plain)
////                
////                //.background(myColor.bgColor.cornerRadius(20))
////                // .padding()
////                //.padding(.horizontal)
////                
////            }else {
////                VStack(spacing: 10) {
////                    Image(systemName: "person.crop.circle.badge.plus")
////                        .resizable()
////                        .scaledToFit()
////                        .frame(width: 100,height: 100)
////                        .foregroundColor(myColor.primaryColor.opacity(0.7))
////                    Text("no content yet add some records")
////                        .font(.subheadline)
////                        .foregroundColor(myColor.textSecondary)
////                }
////                .padding()
////                
////            }
////        } //:VStack
