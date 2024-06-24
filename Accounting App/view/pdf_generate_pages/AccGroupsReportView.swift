//
//  AccGroupsReportView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 14/11/2023.
//

import SwiftUI

struct AccGroupsReportView: View {
    @EnvironmentObject var vm :AccountingAppViewModel
    @EnvironmentObject var reportVm : ReportsViewModel
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 400),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 400), spacing: 10),

        GridItem(.flexible(minimum: 10, maximum: 400), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 400), spacing: 10),
       
        
    ]
   
    
    
     func getAccGroupSammary(accGroupId:String)->(Double,Double) {
        var totalDebit = 0.0;
        var totalCredit = 0.0;
         let customerAccounts = vm.customersAccount.filter({$0.accGroupId == accGroupId && $0.curencyId == reportVm.curencyId })
        
        if !customerAccounts.isEmpty {
            customerAccounts.forEach { cac in
                totalDebit += cac.totalDebit
                totalCredit += cac.totalCredit
            }
           
            
        }
        
        
        return (totalDebit,totalCredit)
        
    }
    func getAccGroupSummary() {
        reportVm.totalDebit = 0;
        reportVm.totalCredit = 0;
        let cacs = vm.customersAccount.filter({$0.curencyId == reportVm.curencyId})
         guard !cacs.isEmpty else {
             return
         }
         cacs.forEach { cac in
             reportVm.totalDebit += cac.totalDebit
             reportVm.totalCredit += cac.totalCredit
         }
    }

    var body: some View {
        VStack {
            HStack {
                    
               
               
              
                ReportAppBarView(title: "إجمالي التصنيفات",action: {
                    exportPDF {
                        self
                        .environmentObject(vm)
                        .environmentObject(reportVm)
                    }completion: { status, url in
                        if let url = url ,status {
                            reportVm.PDFUrl = url
                            reportVm.showshareSheet.toggle()
                        }else {
                            print("Field")
                        }
                    }

                })
                    .padding(.horizontal)
            }
            ReportCurencyView()
                .padding(.horizontal)
                .padding(.bottom)
            
//            Divider()
            AccGroupTableHeaderView()
            ForEach(vm.accGroups) { accGroup in
                
                LazyVGrid(columns: columns) {
                    Text("\(Utilies.formattedValue(using: abs(getAccGroupSammary(accGroupId:accGroup.accGroupID ?? " ").0 - getAccGroupSammary(accGroupId:accGroup.accGroupID ?? " ").1)))")
                        
                        .foregroundColor( getAccGroupSammary(accGroupId:accGroup.accGroupID ?? " ").0 > getAccGroupSammary(accGroupId:accGroup.accGroupID ?? " ").1 ? .red:.green)
                        .font(.body)
                    
                    
                    Text("\(Utilies.formattedValue(using:  getAccGroupSammary(accGroupId:accGroup.accGroupID ?? " ").1))")
                        .foregroundColor(.green)
                        .font(.body)
                    Text("\(Utilies.formattedValue(using:  getAccGroupSammary(accGroupId:accGroup.accGroupID ?? " ").0))")
                        .foregroundColor(.red)
                        .font(.body)
                    
                    HStack {
                        Text(accGroup.accGroupName ?? "")
                            .foregroundColor(myColor.textPrimary)
                        .customFont(size: 12,bold: true)
                    }
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.trailing)
                        
              
                    
                }
                Divider()
            }
           
          ReportsFooterView()
        }
        
        .frame(maxHeight: .infinity,alignment: .top)
        .navigationBarBackButtonHidden(true)
        .onChange(of: reportVm.curencyId, perform: { newValue in
            getAccGroupSummary()
        })
        .onAppear {
            getAccGroupSummary()
       
               
                 
                
        }
        .sheet(isPresented: $reportVm.showshareSheet) {
            reportVm.PDFUrl = nil
        } content: {
            if let PDFUrl = reportVm.PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }

        
       

    }
    
        
}

struct AccGroupsReportView_Previews: PreviewProvider {
    static var previews: some View {
        AccGroupsReportView()
    }
}
struct AccGroupTableHeaderView:View {
    let columns = [
        GridItem(.flexible(minimum: 10, maximum: 100),spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
        GridItem(.flexible(minimum: 10, maximum: 300), spacing: 10),
       
        GridItem(.flexible(minimum: 100, maximum: 500), spacing: 10),
       
        
    ]
    var body: some View {
        VStack {
            Divider()
            HStack {
                LazyVGrid(columns: columns) {
                 
                    Text("المجموع")
                    Text("علية")
                    Text("لة")
                    
                    Text("الأسم")
                }
                
            }
            .customFont(size: 12,bold: true)
            .padding(.vertical,5)
            Divider()
        }
    }
}


struct ShareSheet: UIViewControllerRepresentable {
    var urls : [Any]
    
    func makeUIViewController(context: Context) ->  UIActivityViewController {
        let controller  = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
