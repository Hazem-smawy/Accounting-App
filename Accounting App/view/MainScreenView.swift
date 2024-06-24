//
//  MainScreenView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 31/05/2023.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @State var selection:Int = 0
    @State private var curenciesId:Set<String>? = Set()
    @State private var isPresented:Bool = false
    
    
    
    
    init() {
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,.font :UIFont(name: FontManager.Cairo.bold, size: 14)! ]
    }
    
    var body: some View {
        
        
        
        
        NavigationView {
            ZStack (alignment: .bottomLeading){
                
                VStack {
                    
                    
                    if !vm.accGroups.isEmpty {
                        VStack {
                            TabView(selection: $selection) {
                                
                                
                                
                                ForEach(Array(vm.accGroups.enumerated()) ,id: \.element){ (index,accGroup) in
                                    
                                    let  curencyGrouped = vm.fetchGroupsOfAccGroupsAndCurency(accGroupId: accGroup.accGroupID ?? "")
                                    
                                    CustomTabPageView(
                                        curencies: curencyGrouped, accGroup: accGroup )
                                    .tag(index)
                                    .onAppear {
                                        vm.currentAccGroup = accGroup
                                        
//                                        print(vm.currentAccGroup)
                                    }
                                    
                                }
                                
                                
                                
                                
                                
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .environment(\.layoutDirection, .rightToLeft)
                            
                            
                        }
                        
                        
                        
                        
                        
                    }else {
                        VStack {
                            //  DrawerView()
                            Spacer()
                            Image(systemName: "folder.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70,height: 70)
                                .foregroundColor(myColor.textSecondary)
                            Text("لا يوجد اي تصنيف ")
                                .foregroundColor(myColor.textSecondary)
                                .customFont(size: 14)
//                            NavigationLink {
//                                SettingAccGroupsView()
//                                    .navigationBarBackButtonHidden(true)
//                            } label: {
//
                                
                                Text("إضافة التصنيفات الإفتراضية")
                                    .customFont(size: 14,bold: true)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(myColor.blackColor)
                                    )
                                    .onTapGesture(perform: {
                                        vm.fik()
                                    })
                                
                                    .padding(.horizontal)
                                    .padding(.horizontal)
                            //}
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                    }
                    
                    
                    
                    
                }
                
                
                GeometryReader {geo in
                    VStack {
                        Spacer()
                        DrawerItemsView()
                        
                        Spacer()
                        
                    }
                   
                    .overlay(alignment: .topTrailing, content: {
                        VStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.title3)
                                .foregroundColor(myColor.textSecondary)
                                .onTapGesture {
                                    withAnimation {
                                        vm.openDrawer.toggle()
                                    }
                                }
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    })
                    .padding()
                    .overlay {
                        ZStack(alignment: .trailing) {
                          
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: geo.size.width * 0.25)
                        .background {
                            vm.openDrawer ? Color.black.opacity(0.1) : Color.clear
                        }
                        .offset(x: geo.size.width * 0.25 * 2)
                        .opacity(vm.openDrawer ? 1 : 0)
//                        .animation(.easeIn(duration: 0.2), value: vm.openDrawer)
                        .onTapGesture {
                            vm.openDrawer.toggle()
                        }
                        
                    }
                    .frame(width: geo.size.width * 0.75)
                    .background(myColor.blackColor)
                    .offset(x:vm.openDrawer ? 0 : -geo.size.width)
                    .animation(.easeInOut, value: vm.openDrawer)
                    
                }
                
             
            }
            .background {
                myColor.containerColor.ignoresSafeArea()
            }
            .onAppear {
                vm.statusNotification = false
                if !vm.accGroups.isEmpty {
                    
                    vm.currentAccGroup = vm.accGroups.first
                    curenciesId = vm.fetchGroupsOfAccGroupsAndCurency(accGroupId:vm.currentAccGroup?.accGroupID ?? " ")
                    
                }
                
            }
            
           
            .onChange(of: vm.selectionTap) { newValue in
                selection = newValue ?? selection
            }
            .onChange(of: vm.descTextfild) { newValue in
                withAnimation {
                    withAnimation {
                        
                        vm.isError = nil
                    }
                }
            }
            .overlay(alignment: .center) {
                
                if vm.statusNotification {
                    
                    CustomStatusDialog()
                }
            }
            
            
            
            
        }
        
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        .environment(\.layoutDirection, .rightToLeft)
        
       
        
        
        
    }
}
