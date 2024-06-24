//
//  AddOrEditTitleSittingView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 17/06/2023.
//

import SwiftUI

struct AddOrEditTitleSittingView: View {
    var icon:String
    var title:String
    var body: some View {
        VStack {
            Image(systemName:  icon)
                .resizable()
                .scaledToFit()
                .frame(width: 70,height: 70)
                
            Text(title)
                .customFont(size: 14,bold: true)
                .padding(.bottom)
            
        }
        .foregroundColor(myColor.textSecondary)
    }
}

struct AddOrEditTitleSittingView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrEditTitleSittingView(icon: "person.crop.circle.fill.badge.checkmark", title: "تعد يل")
    }
}
