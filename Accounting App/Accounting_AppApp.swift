//
//  Accounting_AppApp.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 25/05/2023.
//

import SwiftUI

@main
struct Accounting_AppApp: App {
    @StateObject var vm:AccountingAppViewModel = AccountingAppViewModel()
    @StateObject var reportVm :ReportsViewModel = ReportsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .environmentObject(reportVm)
                
            
        }
    }
}

