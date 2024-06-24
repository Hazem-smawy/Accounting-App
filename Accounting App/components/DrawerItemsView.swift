//
//  DrawerItemsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 04/06/2023.
//

import SwiftUI

struct DrawerItemsView: View {
    @State private var isShow:Bool = false
    @EnvironmentObject var vm:AccountingAppViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            VStack {
                
               
                
                VStack {
                    DrawerItemView(icon:"doc.on.doc", name:"التقارير",isFirst: false)
                    Divider()
                        .background(myColor.textSecondary)
                       
                    VStack {
                        ReportsSheet()
                    }
                    .padding(.leading)
                    
                }
                .padding()
                .background {
                    if colorScheme == .dark {
                        myColor.bgColor.opacity(0.1).cornerRadius(20)
                    }else {
                        myColor.containerColor.opacity(0.1).cornerRadius(20)
                    }
                }
                .padding(.trailing)
              

//                DrawerItemView(icon: "list.bullet.clipboard.fill", name: "report for castumer")
//                DrawerItemView(icon: "list.bullet.clipboard.fill", name: "accounts")
                NavigationLink {
                    CustomersAccountView()
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle("")
                } label: {
                    
                    DrawerItemView(icon: "person.2.crop.square.stack", name: " حسابات العملاء")
//                        .onAppear {
//                            vm.openDrawer = false
//                        }
                }
                NavigationLink {
                    SettingsView()
                        .onAppear {
                            if vm.openDrawer == true {
                                
                                vm.openDrawer.toggle()
                            }
                        }
                } label: {
                    DrawerItemView(icon: "gearshape", name: "الاعدادات")
                        
                }
                NavigationLink {
                    SettingsView()
                } label: {
                    DrawerItemView(icon: "phone", name: "contact us")
                        
                }
                NavigationLink {
                    SettingsView()
                } label: {
                    DrawerItemView(icon: "info.circle", name: "about us")
                        
                }
               
                
            }
            .padding()
        }
        
        
    }
}

struct DrawerItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            DrawerItemsView()
               
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(myColor.blackColor)
        .environment(\.layoutDirection, .rightToLeft)
            
    }
}

struct DrawerItemView:View {
    var icon:String
    var name:String
    var isFirst:Bool? = true

    var body: some View {
        VStack {
            
            HStack(spacing:20) {
                Image(systemName:icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                Text(name)
                    .customFont(size: 15,bold: false)
                   
               
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .foregroundColor(.white.opacity(0.7))
            .padding(.bottom,isFirst ?? true ? 10 : 0)
            .overlay(alignment: .bottomTrailing, content: {
                if isFirst ?? true  {
                    
                    Divider()
                        .background(myColor.textSecondary.opacity(0.2))
                        .frame(width: 200)
                }
            })
            
            
                
        }
        
        
    }
}
