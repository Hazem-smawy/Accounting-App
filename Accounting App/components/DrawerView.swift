//
//  DrawerView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 30/05/2023.
//

import SwiftUI

struct DrawerView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @State private var openDrawerItem:Bool = false
    @State private var isSearchOpen:Bool = false
    @State private var searchTextField:String = ""
    @State var accGroup:AccGroup?
    @State var isMenuPresented:Bool = false
    @State private var isReportSheetOpen :Bool = false;
    
    var body: some View {
        
        
        VStack {
            HStack(spacing:10) {
                if isSearchOpen {
                    TextField("search here", text: $searchTextField,prompt: Text("search here").foregroundColor(myColor.containerColor))
                        .padding(7)
                        .background(
                            myColor.containerColor
                                .opacity(0.5)
                                .cornerRadius(8)
                        )
                        .foregroundColor(myColor.textPrimary)
                }else {
                    HStack {
                        Image(systemName: "line.3.horizontal")
    //.font(.title)
                            
                        
                        Text("\(accGroup?.accGroupName ?? "لا يوجد اي تصنيف ")")
                            .font(.custom(FontManager.Cairo.medium, size: 15))
                            .fontWeight(.regular)
                    }
                    .onTapGesture {
                        withAnimation {
                            
                            vm.openDrawer.toggle()
                        }
                    }
                    Spacer()
                    
                }
                
                
                
                
                
                NavigationLink {
                    SettingAccGroupsView()
                        .navigationTitle("")
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName: "folder.badge.plus")
                }

                
                
              

                
//                Menu {
//                    ForEach(Array(vm.subAccGroups.enumerated()),id: \.element) { (i,group) in
//                        HStack {
//
//                            Button {
//
//                                vm.selectionTap = i
//                            } label: {
//                                Text("\(group.accGroupName ?? "" )")
//                                    .multilineTextAlignment(.center)
//                                    .customFont(size: 10)
//                                    .font(.system(.body))
//
//                            }
//                            .customFont(size: 10)
//                        }
//                        .frame(maxWidth: .infinity,alignment: .leading)
//
//
//                    }
//
//                } label: {
//                    Image(systemName: "arrow.up.and.down.text.horizontal")
//                }
//                .customFont(size: 14)
//                .multilineTextAlignment(.center)
//                .menuStyle(.borderlessButton)
//                .font(.title3)
            }
            .frame(maxWidth: .infinity)
            .padding(isSearchOpen ? 5 : 6)
            .padding(.horizontal,10)
            .background(accGroup?.status ?? true ? (myColor.blackColor.cornerRadius(10) ): (myColor.blackColor.cornerRadius(10)))
            .foregroundColor(.white)
            .padding(.horizontal,10)
            
            
        }
        
        .sheet(isPresented: $openDrawerItem) {
            DrawerItemsView()
                .presentationDetents([.medium,.large])
        }
        
        
    }
    
    
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAccGroupView()
    }
}

struct ListOfAccGroupView:View {
    var body: some View {
        VStack {
            Text("كل التصنيفات")
                .customFont(size: 14,bold: true)
            
            ForEach(0...4,id: \.self){ i in
                HStack {
                    Text("this is \(i)")
                }
                .padding(.horizontal)
                .padding(.vertical,5)
                .background(
                    Capsule()
                        .fill(.secondary)
                )
            }
            
        }
        .padding(5)
        .padding(.horizontal,5)
        .background(.thinMaterial)
        .cornerRadius(7)
    }
}
