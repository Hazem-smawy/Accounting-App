//
//  SittingHeaderView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 17/06/2023.
//

import SwiftUI

struct SittingHeaderView: View {
    @Environment(\.dismiss) var dismiss
    var title :String
    var body: some View {
        HStack(spacing:5) {
            HStack {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                Text("رجوع")
                    .customFont(size: 14)
                    .font(.subheadline)
                    .padding(.bottom,3)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
          
            HStack {
                
                Text(title)
                    .customFont(size: 14)
                    .fontWeight(.heavy)
                    .foregroundColor(myColor.textPrimary)
                
               
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {

            }
            .frame(width: 120)
            
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
    }
}

struct SittingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SittingHeaderView( title: "المعلومات الشخصيه")
    }
}
