//
//  CustomDialogView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 24/07/2023.
//

import SwiftUI

struct CustomDialogView: View {
    var action:() ->Void
    var hideDialg:() -> Void
    var description:String

    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.black)
                    .frame(width: 70,height: 70)
                Text("حذف")
                    .customFont(size: 20)
                    .foregroundColor(.red)
                    .fontWeight(.black)
                
                Text(description)
                    .foregroundColor(myColor.textSecondary)
                    .customFont(size: 14)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                CustomBtn(color: Color.red, label: "تأكيد") {
                    action()
                }
                .padding(.top)
                .padding(.horizontal)
                Text("رجوع")
                    .customFont(size: 14)
                    .foregroundColor(myColor.textSecondary)
                    .fontWeight(.regular)
                    .onTapGesture {
                        hideDialg()
                    }
                
            }
            .padding(.vertical)
            .padding()
            .background {
                myColor.bgColor.cornerRadius(20)
            }
            
        }
        .padding()
        .padding(.horizontal)
        .padding(.horizontal)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(myColor.blackColor.opacity(0.5))
        .onTapGesture {
            hideDialg()
        }
        
    }
}

struct CustomDialogView_Previews: PreviewProvider {
    static var previews: some View {
       // CustomDialogView(action: {},hideDialg: {},description: "hel")
        CustomStatusDialog()
            .environmentObject(AccountingAppViewModel())
    }
}

struct CustomStatusDialog:View {
    @EnvironmentObject var vm :AccountingAppViewModel
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Image(systemName: "folder.badge.minus.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 70,height: 70)
                
                
                Text("هذا الحساب موقف مؤقتا, للتفعيل قم بتغير حالة الحساب من الإعدادات.")
                    .foregroundColor(.white.opacity(0.8))
                    .customFont(size: 16)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom,30)
                
                
                NavigationLink {
                    SettingsView()
                        .navigationBarBackButtonHidden(true)
//                        .onDisappear{
//                            withAnimation {
//                                vm.statusNotification = false
//                            }
//                        }
                } label: {
                    
                    
                    
                    Text("الإ نتقال للإعدادات")
                        .customFont(size: 16,bold: true)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.green)
                        )
                    
                    .padding(.top)
                    .padding(.horizontal,30)
                }
                .onTapGesture {
                    vm.statusNotification = false

                }

                Text("إلغاء")
                    .customFont(size: 14)
                    .foregroundColor(.white.opacity(0.4))
                    .fontWeight(.regular)
                    .onTapGesture {
                        withAnimation {
                            vm.statusNotification = false
                        }
                    }
                    .padding(.top)
                
            }
            .padding(.vertical)
            .padding(.vertical)
            
            
            .background {
                myColor.blackColor.cornerRadius(20)
            }
            
        }
        .padding()
        .padding(.horizontal)
        .padding(.horizontal)
       
        
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(myColor.blackColor.opacity(0.7))
        .onTapGesture {
            withAnimation {
                vm.statusNotification = false
            }
        }
       
    }
}
