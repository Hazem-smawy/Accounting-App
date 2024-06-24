//
//  SettingCurencyView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 06/06/2023.
//

import SwiftUI

struct SettingCurencyView: View {
    var width = UIScreen.main.bounds.width - 40
    @State private var isSheetOPen:Bool = false
    @EnvironmentObject var vm :AccountingAppViewModel
    @State private var curencies:[Curency] = []
    @State private var optionalCurency:Curency? = nil
    @Environment(\.dismiss) var dismis
    var body: some View {
        ZStack(alignment:.bottomTrailing) {
            VStack(spacing:10) {
                SittingHeaderView(title: "العملات")
               
                HStack {
                    HStack {
                        
                    }.frame(width: 20)
                    Text("الاسم ")
                    Spacer()
                    Text("الرمز")
                    Spacer()
                    Text("عدد الحسابات")
                       
                   
                    Spacer()
                    HStack {
                        Circle()
                            .fill(.green)
                        .frame(width: 10,height: 10)
                        .padding(.trailing,10)
                    }
                    //.frame(maxWidth: .infinity,alignment: .trailing)
                   
                   
                       
                }
                
                .foregroundColor(myColor.textPrimary.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(myColor.textPrimary.opacity(0.7))
                )
                .customFont(size: 15,bold: true)
                .padding(.horizontal)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                
                VStack {
                    if curencies.isEmpty {
                        VStack {
                            
                            Spacer()
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundColor(myColor.blackColor)
                            
                            Text("ليس هناك اي عملات")
                                .customFont(size: 14)
                                .foregroundColor(myColor.blackColor)
                                
                            Spacer()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }else {
                        List {
                            ForEach(curencies, id: \.self) { curence in
                                HStack (spacing:10){
                                    Image(systemName: "square.and.pencil")
                                        .onTapGesture {
                                            optionalCurency = curence
                                            isSheetOPen.toggle()
                                        }
                                    HStack {
                                        Text(curence.curencyName ?? " ")
                                            .customFont(size: 14)
                                    }
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    
                                    HStack {
                                        Text(curence.curencySymbol ?? " ")
                                            .customFont(size: 14)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text("\(vm.customersAccount.filter({$0.curencyId == curence.curencyId}).count)")
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                    
                                    Circle()
                                        .fill(curence.status ? .green : .red)
                                        .frame(width: 10,height: 10)
                                    
                                }
                                .padding(.horizontal)
                            }
                            .onDelete(perform: { indexSet in
                                
                                vm.deleteCurence(indexSet: indexSet)
                                curencies = vm.curences
                            })
                            
                            .background(myColor.bgColor.cornerRadius(10))
                            
                        }
                        .listStyle(.plain)
                        .background(myColor.bgColor)
                        .multilineTextAlignment(.center)
                        .foregroundColor(myColor.textSecondary)
                    }
                }
                
              
                
                
                
            }
            
           
            .padding(.top)
            .frame(maxHeight: .infinity)
            
            HStack {
                
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(myColor.primaryColor)
                    )
                    .onTapGesture {
                        isSheetOPen.toggle()
                    }
                Spacer()

            }
            .padding()
            .padding(.horizontal)

        }
        .sheet(isPresented: $isSheetOPen, onDismiss: {
            optionalCurency = nil
            withAnimation {
                
                vm.isError = nil
            }

        }, content: {
            AddNewCurency(optionalCurency: $optionalCurency, coins: $curencies, isSheetOPen: $isSheetOPen)
            .presentationDetents([.medium])
            .environment(\.layoutDirection, .rightToLeft)
        })
        

        .onAppear {
            withAnimation {
                curencies = vm.curences
            }
            
            
        }
        
        
    
      
    }
}

struct SettingCurencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCurency(optionalCurency: .constant(nil), coins: .constant([]), isSheetOPen: .constant(true))
            //.environmentObject(AccountingAppViewModel())
    }
}



struct AddNewCurency:View {
    @Binding var optionalCurency:Curency?
    @Binding var coins:[Curency]
    @Binding  var isSheetOPen:Bool
    @State private var nameTextfiled:String = ""
    @State private var symbolTextfiled:String = ""
    @State private var curencyStatus:Bool = true
    @EnvironmentObject var vm:AccountingAppViewModel
    var body: some View {
        VStack(spacing:20) {
            AddOrEditTitleSittingView(icon:"dollarsign.circle", title: optionalCurency != nil ? "تعد يل عملة" :"اضافة عملة")
                if let message = vm.isError {
                    
                ErrorView(message: message)
                  
                }
                Toggle("الحالة", isOn: $curencyStatus)
                .foregroundColor(myColor.textSecondary)
                .customFont(size: 14)
                
            
            HStack {
                CustomTextField(textFieldBind: $nameTextfiled, placeHolder: "اسم العملة")
                CustomTextField(textFieldBind: $symbolTextfiled, placeHolder: "الرمز")
                    .frame(width: 150)
               
           
            }
            
            HStack(spacing:10) {
                CustomSittingBtn(color: myColor.primaryColor, label: optionalCurency == nil ?  MoreWordUsed.add : MoreWordUsed.edit) {
                    if nameTextfiled.count > 1  && !symbolTextfiled.isEmpty{
                        addOrupdateCurency()
                    }else {
                        vm.isError = MyErrorMessage.isEmpty
                    }
                    
                }
                
                CustomSittingBtn(color: Color.secondary, label: "الغاء") {
                    isSheetOPen.toggle()
                }
              

            }
            Spacer()
            
        }
        .padding()
        .padding()
        .onAppear {
            if optionalCurency != nil {
                nameTextfiled = optionalCurency?.curencyName ?? ""
                curencyStatus = optionalCurency?.status ?? curencyStatus
                symbolTextfiled = optionalCurency?.curencySymbol ?? ""
                
            }
        }
        .onChange(of: nameTextfiled) { newValue in
            withAnimation {
                
                vm.isError = nil
            }
        }
        .onChange(of: symbolTextfiled) { newValue in
            withAnimation {
                
                vm.isError = nil
            }
        }

    }
    func addOrupdateCurency() {
        if optionalCurency != nil {
            if vm.curences.filter({$0.curencyName == nameTextfiled || $0.curencySymbol == symbolTextfiled}).count > 1 {
                withAnimation {
                    
                    vm.isError = MyErrorMessage.exit
                }
                return
            }
                    
                    vm.updateCurence(curency: optionalCurency! ,  name: nameTextfiled, symbol: symbolTextfiled,status: curencyStatus)
                
            
            optionalCurency = nil
        }else {
            if vm.curences.contains(where: {$0.curencyName == nameTextfiled})  && vm.curences.contains(where: {$0.curencySymbol == symbolTextfiled}) {
                withAnimation {
                    
                    vm.isError = MyErrorMessage.exit
                }
                return
            }
                    vm.addCurence( name: nameTextfiled, symbol: symbolTextfiled,status: curencyStatus)
                
            
            
        }
       
        coins = vm.curences
        isSheetOPen.toggle()
    }
   
}
                  
      
