//
//  ContentView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 25/05/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm:AccountingAppViewModel
    var body: some View {
        MainScreenView()
            .overlay(alignment:.topLeading) {
               
                if vm.isSnackbarShowing {
                        ZStack {
                            SnackBarView()
                                .transition(.move(edge: .bottom ))
                                .padding(.top,50)
                        }
                    }
    //
                
            }
            .environment(\.locale, Locale(identifier: "en"))
//            .onAppear {
//                vm.currentCurency = vm.curences.first
//            }
            
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AccountingAppViewModel())

    }
}
