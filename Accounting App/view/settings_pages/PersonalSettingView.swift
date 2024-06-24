//
//  PersonalSettingView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 25/07/2023.
//

import SwiftUI

struct PersonalSettingView: View {
    @State private var isPresent:Bool = false
    @EnvironmentObject var vm:AccountingAppViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
        
            HStack(spacing:5) {
                HStack {
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                    Text("رجوع")
                        .customFont(size: 14)
                        .font(.subheadline)
                        .padding(.bottom,3)
                }
               // .frame(maxWidth: .infinity,alignment: .leading)
              
                HStack {
                    
                    Text("المعلومات الشخصية")
                        .customFont(size: 14)
                        .fontWeight(.heavy)
                        .foregroundColor(myColor.textPrimary)
                    
                   
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
               Spacer()
                
            }
            .onTapGesture {
                dismiss()
            }
            .foregroundColor(myColor.textSecondary)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background( RoundedRectangle(cornerRadius: 12)
               // .stroke(myColor.textSecondary)
                .fill(myColor.settingColor)
            )
            .padding(.horizontal)
            .environment(\.layoutDirection, .rightToLeft)
            if vm.personalInfo != nil {
            VStack {
               
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                    .background {
                        Circle()
                            .stroke(.black,lineWidth: 2)
                    }
                
                    
                    VStack(spacing:10) {
                        HStack {
                            
                            Text(vm.personalInfo?.name ?? "لايوجد اسم")
                                .customFont(size: 16)
                                .fontWeight(.black)
                            Image(systemName: "person")
                                .fontWeight(.black)
                            
                        }
                        .padding(.bottom)
                        .frame(maxWidth: .infinity,alignment: .trailing)

                       
                        
                        HStack(spacing:15) {
                            Text(vm.personalInfo?.email ?? "لايوجد بريد ")
                            Image(systemName: "envelope")
                                
                        }
                        .foregroundColor(myColor.textSecondary)
                        .frame(maxWidth: .infinity,alignment: .trailing)

                        HStack(spacing:15) {
                            Text(vm.personalInfo?.phone ?? "لايوجد رقم")
                            Image(systemName: "phone")
                                
                        }
                        .foregroundColor(myColor.textSecondary)
                        .frame(maxWidth: .infinity,alignment: .trailing)

                        HStack (spacing:15){
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                                .onTapGesture {
                                    isPresent.toggle()
                                }
                            Spacer()
                            Text(vm.personalInfo?.address ?? "لايوجد عنوان")
                            Image(systemName: "mappin.and.ellipse")
                            
                        }
                        .foregroundColor(myColor.textSecondary)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        
                    }
                    .padding(.top,30)
               
              
            }
            .padding()
          
            .background(
                myColor.containerColor.cornerRadius(12))
            .padding()
            Spacer()
            }else {
                VStack {
                    Spacer()
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .padding()
                    Text("قم باضافه بعض المعلومات الشخصيه للحصول على جميع الخدمات المتاحه")
                        .customFont(size: 14)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    CustomBtn(color: myColor.blackColor, label: "اضف بعض المعلومات") {
                        isPresent.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                    
                    Spacer()
                    Spacer()
                   
                        
                    
                }
            }

        }
        .onAppear {
            vm.fetchPersonalInfo()
        }
        .sheet(isPresented: $isPresent) {
            EditPersonalInfo()
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .environment(\.layoutDirection, .rightToLeft)
            
        }
        .environment(\.layoutDirection, .leftToRight)
        
    }
}

struct PersonalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettingView()
            .environmentObject(AccountingAppViewModel())
            .background(myColor.bgColor)
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct EditPersonalInfo:View {
    @State private var name:String = ""
    @State private var number:String = ""
    @State private var email:String = ""
    @State private var address:String = ""
    @EnvironmentObject var vm:AccountingAppViewModel
    @Environment(\.dismiss) var dismis

    var body: some View {
        VStack(spacing:15) {
            CustomTextField(textFieldBind: $name, placeHolder: "الاسم")
            CustomTextField(textFieldBind: $email, placeHolder: "البريد الالكتروني")
            CustomTextField(textFieldBind: $number, placeHolder: "الهاتف")
            CustomTextField(textFieldBind: $address, placeHolder: "العنوان")
            
            CustomBtn(color: myColor.primaryColor, label: "تأكيد") {
                if vm.personalInfo == nil {
                    if !name.isEmpty && !email.isEmpty  {
                        
                        vm.addPersonalInfo(name: name, phone: number, address: address, email: email)
                    }else {
                        vm.isSnackbarShowing = true
                        vm.snakbar = .init(message: "حقل الاسم و حقل البريد الإلكتروني لايوجد فيها بيانات", color: Color.red, icon: "exclamationmark.bubble.fill")
                        
                    }
                }else {
                    vm.personalInfo?.name = name
                    vm.personalInfo?.email = email
                    vm.personalInfo?.phone = number
                    vm.personalInfo?.address = address
                    vm.savePerson()
                }
                dismis()
            }
            .padding(.top)
        }
        .padding()
        .padding(.horizontal,10)
        .onAppear {
            name = vm.personalInfo?.name ?? ""
            number = vm.personalInfo?.phone ?? ""
            email = vm.personalInfo?.email ?? ""
            address = vm.personalInfo?.address ?? ""
        }
        
    }
}
