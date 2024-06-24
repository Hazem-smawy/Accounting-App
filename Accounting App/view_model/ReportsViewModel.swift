//
//  ReportsViewModel.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 13/11/2023.
//

import Foundation

class ReportsViewModel :ObservableObject {
    @Published var curencyId:String?
    @Published var accGroupId:String?
    
    @Published var totalDebit:Double = 0;
    @Published var totalCredit:Double = 0;
    
    @Published var PDFUrl:URL?
    @Published var showshareSheet :Bool = false
}
