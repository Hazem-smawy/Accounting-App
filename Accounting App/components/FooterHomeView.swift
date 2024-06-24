////
////  FooterHomeView.swift
////  Accounting App
////
////  Created by B-ALDUAIS on 30/05/2023.
////
//
//import SwiftUI
//
//struct FooterHomeView: View {
//    @Binding var forYou:Double
//    @Binding var onYou:Double
//    @EnvironmentObject var vm:AccountingAppViewModel
//    var body: some View {
//        HStack {
//            NavigationLink(destination: NewAccountingView()) {
//                Image(systemName: "plus")
//                    .padding(10)
//                    .background(
//                        Circle()
//                            .fill(myColor.primaryColor)
//                    )
//                    .font(.title2)
//                    .foregroundColor(myColor.bgColor)
//                    
//            }
//            Spacer()
//            VStack {
//                HStack {
//                    Spacer()
//                    Text("عليك")
//                        .customFont(size: 14)
//                    
//                    Text("\(Int(onYou))")
//                       //.font(.headline)
//                        .foregroundColor(.green)
//                       .customFont(size: 14,bold: true)
//                    
//                   Spacer()
//                       Text("لك")
//                        
//                           .customFont(size: 14)
//                     
//                    Text("\(Int(abs(forYou)))")
//                        .font(.headline)
//                        .foregroundColor(.red)
//                        .customFont(size: 14,bold: true)
//                    
//                   Spacer()
//                    
//                    
//                }
//                
//                Text(vm.currentCurency?.curencyName ?? " ")
//                    .font(.body)
//                
//            }
//            
//            Spacer()
//           
//            
//        }
//        .foregroundColor(myColor.textSecondary)
//        .padding()
//        .frame(height: 57)
//        .background(myColor.containerColor.cornerRadius(20).edgesIgnoringSafeArea(.bottom))
//       // .customShadow()
//        .padding()
//    }
//}
//
//struct FooterHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        FooterHomeView(forYou: .constant(0), onYou: .constant(0))
//    }
//}
