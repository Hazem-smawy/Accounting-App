//
//  SettingsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 04/06/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        ZStack {
            VStack {
                SittingHeaderView(title: "كل الاعدادات")
                    .padding(.bottom,10)
                    Form {
                        Section {
                            NavigationLink {
                                PersonalSettingView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                
                                SettingItemView(icon: "person", name: "المعلومات الشخصية")
                            }

                          
                        } header: {
                            Text("personal info")
                        }
                    
                    
                        
                        Section {
                            NavigationLink {
                                SettingCustomerView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                
                                
                                SettingItemView(icon:  "person.2", name: "العملاء")
                                
                            }
                            NavigationLink {
                                SettingAccGroupsView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                
                                
                                SettingItemView(icon:  "doc.on.clipboard", name: "التصنيفات")
                            }
                            NavigationLink {
                                SettingCurencyView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                
                                SettingItemView(icon:  "dollarsign", name: "العملات")
                            }


                        } header: {
                            Text("account setting")
                        }
                        
                        Section {
                            SettingItemView(icon:  "person", name: "person")
                            SettingItemView(icon:  "person", name: "person")
                            SettingItemView(icon:  "person", name: "person")

                        } header: {
                            Text("general settings")
                        }

                    }
                   // .background(myColor.containerColor)
                    .formStyle(.grouped)
                    .cornerRadius(20)
                      
                
                   
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingItemView:View {
    var icon:String
    var name:String
    var body: some View {
        HStack(spacing:20) {
            Image(systemName: icon)
                .customFont(size: 14)
            Text(name)
                .customFont(size: 14,bold: false)
                
            Spacer()
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .font(.title3)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .foregroundColor(myColor.textSecondary)
    }
}
