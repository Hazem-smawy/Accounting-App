//
//  SettingAccGroupsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 06/06/2023.
//

import SwiftUI

struct SettingAccGroupsView: View {
   
    var width = UIScreen.main.bounds.width - 40
    @State private var isSheetOPen:Bool = false
    @EnvironmentObject var vm :AccountingAppViewModel
    @State private var accGroups:[AccGroup] = []
    @State private var optionalaccGroup:AccGroup? = nil
    @Environment(\.dismiss) var dismis
    var body: some View {
        ZStack(alignment:.bottomLeading) {
           
            VStack(spacing:10) {
                SittingHeaderView(title: "تصنيف الحسابات")
                HStack {
                    HStack {
                        
                    }.frame(width: 20)
                  
                   
                    Text("التصنيف")
                    
                    Spacer()
                    Text("عدد الحسابات")
                    Spacer()
                    Circle()
                        .fill(.green)
                        .frame(width: 10,height: 10)
                        .padding(.trailing, 10)
                   
                       
                }
                .foregroundColor(myColor.textPrimary.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(myColor.textPrimary.opacity(0.5))
                )
                
                .customFont(size: 14,bold: true)
                .padding(.horizontal)
                .frame(height: 50)
                
                VStack {
                    List {
                        ForEach(accGroups, id: \.self) { accGroup in
                            HStack (spacing:10){
                                Image(systemName: "square.and.pencil")
                                .onTapGesture {
                                    optionalaccGroup = accGroup
                                    isSheetOPen.toggle()
                                }
                                HStack {
                                    Text(accGroup.accGroupName ?? " ")
                                        .customFont(size: 13)
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                               // .multilineTextAlignment(.leading)
                                    
                                HStack {
                                    Text("\( (vm.customersAccount.filter({$0.accGroupId == accGroup.accGroupID}).count))")
                                    
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                               // .multilineTextAlignment(.leading)
                                Spacer()
                                Circle()
                                    .fill(accGroup.status ? .green : .red)
                                    .frame(width: 10,height: 10)
                                }
                            .onTapGesture {
                                optionalaccGroup = accGroup
                                isSheetOPen.toggle()
                            }
                                .padding(.horizontal)
                            }
                        .onDelete(perform: { indexSet in
                            vm.deleteAccGroup(indexSet: indexSet)
                            accGroups = vm.accGroups
                        })
                        
                        .background(myColor.bgColor.cornerRadius(10))

                    }
                    .listStyle(.plain)
                    
                    .multilineTextAlignment(.center)
                .foregroundColor(myColor.textSecondary)
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

            }
            .padding()
            .padding(.horizontal)

        }
        
        .sheet(isPresented: $isSheetOPen, onDismiss: {
            optionalaccGroup = nil
            withAnimation {
                
                vm.isError = nil
            }

        }, content: {
            AddNewAccGroup(optionalAccGroup: $optionalaccGroup, accGroups: $accGroups, isSheetOPen: $isSheetOPen)
            .presentationDetents([.medium])
            .environment(\.layoutDirection, .rightToLeft)
        })
       

        .onAppear {
            withAnimation {
                accGroups = vm.accGroups
            }
            
            
        }
        
        
    
      
    }}

//struct SettingAccGroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewCurency()
//            .environmentObject(AccountingAppViewModel())
//    }
//}


struct AddNewAccGroup:View {
    @Binding var optionalAccGroup:AccGroup?
    @Binding var accGroups:[AccGroup]
    @Binding  var isSheetOPen:Bool
    @State private var nameTextfiled:String = ""
    @State private var accGroupStatus:Bool = true
    @EnvironmentObject var vm:AccountingAppViewModel
    var body: some View {
        VStack(spacing:20) {
            AddOrEditTitleSittingView(icon: "folder.fill.badge.plus", title:optionalAccGroup == nil ? "اضافة تصنيف":"تعديل تصنيف")
                
                if let message = vm.isError {
                    
                ErrorView(message: message)
                  
                }
                Toggle("الحالة", isOn: $accGroupStatus)
                .customFont(size: 12)
                .foregroundColor(myColor.textSecondary)
                
            
            HStack {
                
               
                CustomTextField(textFieldBind: $nameTextfiled, placeHolder: "اسم التصنيف")
           
            }
            
            
            HStack {
                CustomSittingBtn(color: .green, label: optionalAccGroup == nil ? MoreWordUsed.add : MoreWordUsed.edit) {
                    if !nameTextfiled.isEmpty{
                        
                        
                        addOrupdateAccGroup()
                    }else {
                        vm.isError = MyErrorMessage.isEmpty
                    }
                }
                
                CustomSittingBtn(color: .secondary, label: "الغاء") {
                    isSheetOPen.toggle()
                }
               
               

            }
            Spacer()
            
        }
        .padding()
        .padding()
        .onAppear {
            if optionalAccGroup != nil {
                nameTextfiled = optionalAccGroup?.accGroupName ?? ""
                accGroupStatus = optionalAccGroup?.status ?? accGroupStatus
                
            }
        }
        .onChange(of: nameTextfiled) { newValue in
            withAnimation {
                
                vm.isError = nil
            }
        }
    }
    func addOrupdateAccGroup() {
        if optionalAccGroup != nil {
            if vm.accGroups.filter({$0.accGroupName == nameTextfiled}).count > 1 {
                withAnimation {
                    
                    vm.isError = MyErrorMessage.exit
                }
                return
            }
                    
                    vm.updateAccGroup(accGroup: optionalAccGroup!, name: nameTextfiled, status: accGroupStatus)
            
            optionalAccGroup = nil
        }else {
            if vm.accGroups.contains(where: {$0.accGroupName == nameTextfiled}) {
                withAnimation {
                    
                    vm.isError = MyErrorMessage.exit
                }
                return
            }
                    vm.addAccGroup( name: nameTextfiled,status: accGroupStatus)
                
            
            
        }
       
        accGroups = vm.accGroups
        isSheetOPen.toggle()
    }
}
                  
      
