//
//  SearchView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 31/07/2023.
//

import SwiftUI

struct SearchView: View {
    @State var search:String = ""
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("بحث" , text: $search)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .customFont(size: 15)
            }
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(myColor.settingColor)
            )
            
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
