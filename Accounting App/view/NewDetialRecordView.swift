////
////  NewDetialRecordView.swift
////  Accounting App
////
////  Created by B-ALDUAIS on 31/05/2023.
////
//
//import SwiftUI
//
//struct NewDetialRecordView: View {
//    @State var account:AccountEntity
//    
//    @Binding var isPresented:Bool
//    @State private var nameTextfild:String = ""
//    @State private var descTextfild:String = ""
//    @State private var moneyTextfiled:String = ""
//    @State private var coinTextfiled:String = ""
//
//    @EnvironmentObject var vm :AccountingAppViewModel
//    
//    
//  
//    var body: some View {
//        
//        ZStack(alignment:.top) {
//          
//            VStack {
//                HStack {
//                }
//                .frame(width: 100,height: 7)
//                .background(.black.opacity(0.8))
//                .cornerRadius(10)
//                .onTapGesture {
//                   // isPresented = nil
//                    isPresented.toggle()
//                }
//                
//                Spacer()
//            }
//            .padding()
//            
//            
//            
//            VStack(spacing:10) {
//                Spacer()
//                HStack(spacing:10) {
//                    TextField("money", text: $moneyTextfiled)
//                        
//                        .padding()
//                        .background(.thickMaterial)
//                        .cornerRadius(10)
//                    
//                    HStack {
//                        Text(account.name ?? " ")
//                            .fontWeight(.bold)
//                    }
//                       
//                        .padding()
//                        .background(.black.opacity(0.5))
//                        .foregroundColor(.white)
//                        
//                        .cornerRadius(10)
//                }
//                TextField("description", text: $descTextfild)
//                   
//                    .padding()
//                    .background(.thickMaterial)
//                    .cornerRadius(10)
//                
//                HStack {
//                    HStack(spacing:10) {
//                        Circle()
//                            .stroke()
//                            .frame(width: 20,height: 20)
//                        Text("dolar")
//                            .font(.subheadline)
//                    }
//                    HStack(spacing:10) {
//                        Circle()
//                            .stroke()
//                            .frame(width: 20,height: 20)
//                        Text("soudi")
//                            .font(.subheadline)
//                    }
//
//                    HStack(spacing:10) {
//                        Circle()
//                            .stroke()
//                            .frame(width: 20,height: 20)
//                        Text("local")
//                            .font(.subheadline)
//                    }
//                    
//                   
//
//                        
//                    
//                }
//                .padding(.top)
//                
//                HStack {
//                    Button {
//                       newRecordToAccount( description: descTextfild, forHem: true, money: moneyTextfiled)
//                    } label: {
//                        HStack {
//                            Text("for hem")
//                                .font(.title3)
//                                .foregroundColor(.white)
//                            
//                            
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal)
//                    .padding(.vertical)
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.green)
//                    )
//                    
//                    Button {
//                        //on hem
//                        newRecordToAccount( description: descTextfild, forHem: false, money: moneyTextfiled)
//                    } label: {
//                        HStack {
//                            
//                            Text("on hem")
//                                .font(.title3)
//                                .foregroundColor(.white)
//                            
//                            
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal)
//                    .padding(.vertical)
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.red)
//                    )
//
//
//                }
//                .padding(.top)
//                
//                Spacer()
//                Spacer()
//            }
//            .padding()
//          
//            
//        }
//        
//      
//       
//        
//    }
//        
//        
//        
//        
//        
//    
//    func newRecordToAccount( description:String,forHem:Bool,money:String){
//        let date = Date.now
//       
//        
//        if  !description.isEmpty && !money.isEmpty {
//            vm.addDetailEntityToAccount(account: account, money: Double(money)!, desc: description, date: date, forHem: forHem)
//        }
//        
//        isPresented.toggle()
//       
//        
//        
//    }
//}
//
////struct NewDetialRecordView_Previews: PreviewProvider {
////    static var previews: some View {
////        NewDetialRecordView()
////    }
////}
