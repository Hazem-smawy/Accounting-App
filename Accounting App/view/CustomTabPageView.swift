//
//  CustomTabPageView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 16/07/2023.
//

import SwiftUI

struct CustomTabPageView: View {
    
    var  curencies:Set<String>
    @EnvironmentObject var vm:AccountingAppViewModel
    @State  var customersAccount :[CustomerAccount] = []
    @State private var selectionCurency:Curency?
    @State private var isListView:Bool = false
    @State private var isInit:Bool = true
    @State private var forYouMoney:Double = 0
    @State private var forHemMoney:Double = 0
    
    @State private var emptyCurency:Bool = false
    @State var isPresented:Bool = false
    
    
    @State var accGroup:AccGroup
    @State private var  selection = 0
    var body: some View {
        ZStack {
            if  !curencies.isEmpty {
                
                
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        
                        DrawerView(accGroup: accGroup)
                        //MARK: sammary - view
                        HStack {
                            VStack(alignment: .leading) {
                                Image(systemName: "chevron.compact.up")
                                    .resizable()
                                    .frame(width: 16,height: 7)
                                    .font(.body)
                                    .foregroundColor(.green)
                                    .padding(10)
                                    .padding(.vertical,5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.black.opacity(0.09))
                                    }
                                HStack {
                                    
                                    Text("\(Utilies.formattedValue(using: forHemMoney))")
                                        .foregroundColor(myColor.textPrimary)
                                        .customFont(size: 16,bold: true)
                                        .padding(.top,5)
                                    
                                    Text("\(selectionCurency?.curencySymbol ?? "")")
                                        .foregroundColor(myColor.textSecondary)
                                        .customFont(size: 12,bold: true)
                                        .padding(.top,5)
                                        .offset(x:-3,y: 5)
                                }
                                
                                Text("عليك")
                                    .foregroundColor(myColor.textSecondary)
                                    .customFont(size: 12)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                
                                    .fill( myColor.bgColor )
                                
                            }
                            VStack(alignment: .leading) {
                                Image(systemName: "chevron.compact.down")
                                    .resizable()
                                    .frame(width: 16,height: 7)
                                    .font(.body)
                                    .foregroundColor(.red)
                                    .padding(10)
                                    .padding(.vertical,5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.black.opacity(0.09))
                                    }
                                
                                HStack {
                                    
                                    Text("\(Utilies.formattedValue(using: abs(forYouMoney)))")
                                        .foregroundColor(myColor.textPrimary)
                                        .customFont(size: 16,bold: true)
                                        .padding(.top,5)
                                    
                                    Text("\(selectionCurency?.curencySymbol ?? "")")
                                        .foregroundColor(myColor.textSecondary)
                                        .customFont(size: 12,bold: true)
                                        .padding(.top,5)
                                        .offset(x:-3,y: 2)
                                }
                                
                                Text(" لك")
                                    .foregroundColor(myColor.textSecondary)
                                    .customFont(size: 12)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill( myColor.bgColor )
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top,10)
                        
                        HomeScreen(customerAccounts: $customersAccount)
                            .padding(.top,10)
                        
                        
                        
                    }
                    if isListView  && curencies.count > 1 {
                        CurrencyListView(curencies: curencies, isListShowing: $isListView, selectedCurency: $selectionCurency)
                            .padding(.horizontal)
                        
                            .padding(.bottom,80)
                        
                    }
                    if selectionCurency != nil  {
                        
                        HStack {
                            
                            
                            
                            if !vm.accGroups.isEmpty {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .padding()
                                
                                    .background {
                                        Circle()
                                            .fill(accGroup.status ? myColor.primaryColor : .secondary)
                                    }
                                    .padding()
                                    .padding(.horizontal,10)
                                    .padding(.bottom)
                                    .onTapGesture {
//                                        vm.currentCurency = selectionCurency
//                                        vm.currentAccGroup = accGroup
                                        if accGroup.status   {
                                            
                                            isPresented.toggle()
                                        }else {
                                            vm.statusNotification = true
                                        }
                                    }
                            }
                            Spacer()
                            HStack {
                                
                                
                                Text("\(selectionCurency?.curencyName ?? " ")")
                                    .foregroundColor( selectionCurency?.status ?? true ? myColor.textSecondary : myColor.bgColor)
                                    .customFont(size: 12,bold: true)
                                Divider()
                                    .frame(height: 15)
                                    .foregroundColor(selectionCurency?.status ?? true ? Color.secondary : myColor.bgColor)
                                Text("\(selectionCurency?.curencySymbol ?? " ")")
                                    .customFont(size: 12,bold: true)
                                    .foregroundColor(selectionCurency?.status ?? true ? myColor.textSecondary : myColor.bgColor)
                                
                            }
                            .padding(.horizontal)
                            .padding(.vertical,5)
                            .background {
                                Capsule()
                                    .fill(selectionCurency?.status ?? true ? myColor.bgColor : Color.secondary)
                                
                            }
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    
                                    isListView.toggle()
                                }
                            }
                            .padding(.bottom)
                        }
                        
                        
                        
                    }
                }
                
                .onChange(of: selectionCurency, perform: { newValue in
                    customersAccount = vm.fetchCustomerAccountsForAccGroupAndCurency(accGroupId:  accGroup.accGroupID ?? "" , curencyId: newValue?.curencyId ?? "")
                    vm.currentCurency = selectionCurency
                    getMoneyForHemAndYou(cac: customersAccount)
                })
                .onChange(of: vm.customersAccount, perform: { newValue in
                    customersAccount = newValue.filter({ cac in
                        cac.curencyId == vm.currentCurency?.curencyId
                        && cac.accGroupId == vm.currentAccGroup?.accGroupID
                    })
                    
                    selectionCurency = vm.currentCurency
                    
                    getMoneyForHemAndYou(cac: customersAccount)
                })
                .onChange(of: vm.isUpdated, perform: { newValue in
                    getMoneyForHemAndYou(cac: customersAccount)
                })
              
                .onAppear {
                    isListView = false
                    if  curencies.contains(where: {$0 == vm.currentCurency?.curencyId ?? ""}) {
                        selectionCurency = vm.curences.first(where: {$0.curencyId == vm.currentCurency?.curencyId})
                        
                       
                    } else {
                        
                        
                        selectionCurency =  vm.curences.first(where: {$0.curencyId == curencies.first})
                        vm.currentCurency = selectionCurency
                       
                    }
                    customersAccount = vm.fetchCustomerAccountsForAccGroupAndCurency(accGroupId:  accGroup.accGroupID ?? "" , curencyId: selectionCurency?.curencyId ?? "")
                    getMoneyForHemAndYou(cac: customersAccount)
                   
                    
                    
                    
                }
            }else {
                VStack {
                    DrawerView(accGroup: accGroup)
                    Spacer()
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(myColor.textPrimary)
                    
                    Text("ليس هناك اي حسابات في هذا التصنيف")
                        .customFont(size: 14)
                        .foregroundColor(myColor.textPrimary)
                    
                    Spacer()
                    Spacer()
                    
                    HStack {
                        
                        
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding()
                            
                            .background {
                                Circle()
                                    .fill(accGroup.status ? myColor.primaryColor : .secondary)
                            }
                            .padding()
                            .padding()
                            .onTapGesture {
                                print("acc: \(accGroup)")
                                if accGroup.status  {
                                    
                                    isPresented.toggle()
                                }else {
                                    vm.statusNotification = true
                                }
                                
                            }
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    isPresented.toggle()
                }
                .onAppear {
                    if vm.currentCurency == nil && !vm.curences.isEmpty {
                        vm.currentCurency = vm.curences[0]
                    }
                }
                
            }
        } .sheet(isPresented: $isPresented) {
            vm.descTextfild = ""
            isListView = false
            
        } content: {
            
                NewAccountingView(accGroup: $accGroup, curency: bindingValue)
                    .presentationDragIndicator(Visibility.visible)
                    .presentationDetents([.medium])
                    .environment(\.layoutDirection, .rightToLeft)
            
        }
        
    }
    private var bindingValue:Binding<Curency> {
        Binding {
            selectionCurency ?? Curency()
        } set: { newValue in
            selectionCurency = newValue
        }

    }
    
    func getMoneyForHemAndYou(cac:[CustomerAccount]) {
        forYouMoney = 0.0
        forHemMoney = 0.0
        for  c in cac {
            var forUser = 0.0
            
            forUser +=  c.totalCredit - c.totalDebit
            
            
            if forUser > 0 {
                forHemMoney += forUser
            }else {
                forYouMoney += forUser
            }
            
            
        }
    }
}




struct CurrencyListView  :View {
    var  curencies:Set<String>
    @Binding var isListShowing:Bool
    
    @EnvironmentObject var vm:AccountingAppViewModel
    @Binding var selectedCurency:Curency?
    
    var body: some View {
        VStack(spacing:5) {
            ForEach(Array(curencies), id:\.self) { curency in
                let curencyName  = vm.curences.first(where: {$0.curencyId ?? "" == curency})
                
                
                
                
                ZStack(alignment:.leading) {
                    
                    HStack {
                        Text(curencyName?.curencyName ?? " ")
                            .foregroundColor(myColor.bgColor)
                            .customFont(size: 12,bold: true)
                        Divider()
                            .frame( width: 2,height: 15)
                        
                            .background(myColor.containerColor)
                            .foregroundColor(myColor.containerColor)
                        Text(curencyName?.curencySymbol ?? " ")
                            .customFont(size: 12,bold: true)
                            .foregroundColor(myColor.bgColor)
                        
                        
                        
                        
                    }
                    
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    
                    .frame(width: 200,alignment: .center)
                    .background(
                        Color.secondary.cornerRadius(10)
                    )
                    
                    .onTapGesture {
                        selectedCurency = curencyName!
                        isListShowing.toggle()
                    }
                    
                    if selectedCurency?.curencyId == curency {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                            .foregroundColor(myColor.lightGreenColor)
                            .offset(x:10)
                    }
                }
                
                
            }
            
            
            
            
        }
        .frame(width: 200)
        .padding(3)
        .background(myColor.bgColor)
        .cornerRadius(10)
    }
    
}

//struct CurrencyListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyListView()
//    }
//}
