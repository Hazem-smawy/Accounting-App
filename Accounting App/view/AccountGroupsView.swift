//
//  AccountGroupsView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 13/06/2023.
//

//import SwiftUI
//import CoreData
//
//struct AccountGroupsView<T:AccRestriction,Content:View>: View {
//    @FetchRequest var fetchRequest:FetchedResults<T>
//    let content:(T)->Content
//
//    init(filterKey:String,filterValue:String,@ViewBuilder content:@escaping (T)-> Content){
//        _fetchRequest = FetchRequest<T>(sortDescriptors: [],predicate: NSPredicate(format: "%K == %@", filterKey,filterValue))
//        self.content = content
//
//    }
//
//    @State private var groupAccRestriction = Dictionary<Int32, Any>()
//
//    var body: some View {
//        List(fetchRequest,id: \.self){item in
//            self.content(item)
//
//        }
//        .onAppear {
//            groupAccRestriction  = Dictionary(grouping: fetchRequest, by: { $0.customerId})
//
//        }
//    }
//
//
//
//}

//struct AccountGroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountGroupsView()
//    }
//}
