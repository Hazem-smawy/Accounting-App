//
//  SettingsAddCategory.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 04/06/2023.
//

import SwiftUI

struct SettingsAddCategoryView: View {
   
}

struct SettingsAddCategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddNewCurency(coins:.constant([]) , isSheetOPen: .constant(false))
            .environmentObject(AccountingAppViewModel())
    }
}
