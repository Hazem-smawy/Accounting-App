//
//  CurencyView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 27/07/2023.
//

import SwiftUI

struct CurencyView: View {
    @EnvironmentObject var vm:AccountingAppViewModel
    var body: some View {
        HStack {
         
            Text("العمله")
                .customFont(size: 14,bold: true)
                .foregroundColor(myColor.textSecondary)
               
            Spacer()
            Text(vm.currentCurency?.curencySymbol ?? " ")
                .customFont(size: 14)
                .foregroundColor(myColor.textSecondary)
            Spacer()
            Text(vm.currentCurency?.curencyName ?? " ")
                .customFont(size: 14,bold: true)
                .foregroundColor(myColor.textPrimary)
            

        }
        .padding(.horizontal,5)
        //.padding(5)
        .frame(maxWidth: .infinity)
//        .background(.thinMaterial)
//        .cornerRadius(7)
    }
}

struct CurencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurencyView()
            .environmentObject(AccountingAppViewModel())
            .padding()
    }
}
