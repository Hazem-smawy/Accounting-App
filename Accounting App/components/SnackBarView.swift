//
//  SnackBarView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 22/07/2023.
//

import SwiftUI



struct SnackBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SnackBarView()
                .environmentObject(AccountingAppViewModel())
                
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}


struct SnackBarView: View {
    
    @EnvironmentObject var vm:AccountingAppViewModel
    
    var body: some View {
        
        VStack {
            HStack(spacing:0) {
                HStack {
                    
                }
                .frame(width: 4,height: 25)
                .background(vm.snakbar?.color ?? .green)
                .cornerRadius(3)
                HStack {
                    
                    Image(systemName: vm.snakbar?.icon ?? "folder.fill.badge.plus")
                        .foregroundColor(vm.snakbar?.color ?? .green)
                    Text(vm.snakbar?.message ?? "")
                        .customFont(size: 14,bold: false)
                    Spacer()
                    
                    Image(systemName: "return.right")
                        .fontWeight(.bold)
                        .foregroundColor(vm.snakbar?.color ?? .green)
                }
                .foregroundColor(myColor.textPrimary)
                .padding(.horizontal,7)
                .padding(.vertical,7)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(myColor.bgColor)
                
            .cornerRadius(8)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black.opacity(0.1))
            )
            .shadow(color: Color.black.opacity(0.09),  radius: 10,x: 1,y: 0)
            .shadow(color: Color.black.opacity(0.5),  radius: 50,x: 1,y: 0)

                
        }
        .frame(maxWidth: .infinity,alignment: .center)
        .animation(.easeInOut,value: vm.isSnackbarShowing)
        .transition(.move(edge: vm.isSnackbarShowing ? .leading: .trailing))
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                withAnimation {
                    vm.isSnackbarShowing = false
                    vm.snakbar = nil
                }
            }
        }
        .environment(\.layoutDirection,.rightToLeft)
    }
}
