//
//  SettingAddCoinView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 04/06/2023.
//

import SwiftUI

struct SettingAddCoinView: View {
    var width = UIScreen.main.bounds.width - 40
    @State private var isSheetOPen:Bool = false
    @State private var addCoinTextfiled:String = ""
    var body: some View {
        ZStack(alignment:.bottomTrailing) {
            VStack {
                HStack {
                    Text("number of account")
                        //.frame(width: width * 0.5)
                    Spacer()
                    Text("coins")
                       // .frame(width: width * 0.5)
                }
                .multilineTextAlignment(.center)
                .padding()
                .background(myColor.containerColor.cornerRadius(12))
                .font(.title3)
                VStack {
                    HStack {
                        Text("2")
                        Spacer()
                        Text("local")
                    }
                    Divider()
                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(myColor.textSecondary)
                
              
                
                Spacer()
                
            }
            
           
            .padding()
            .frame(maxHeight: .infinity)
            
            HStack {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(myColor.primaryColor)
                    )
                    .onTapGesture {
                       // isAddDetialOpen = true
                        //rowOptional = row
                        isSheetOPen.toggle()
                    }

            }
            .padding()
            .padding(.horizontal)

        }
        .sheet(isPresented: $isSheetOPen, content: {
            VStack(spacing:20) {
                
                Text("add conins")
                    .font(.title3)
                    .foregroundColor(myColor.textPrimary)
                    .padding(.vertical)
                    
                
                TextField("add conin",text: $addCoinTextfiled)
                    .padding()
                    .background(myColor.containerColor.cornerRadius(12))
                
                HStack {
                    
                    Button {
                        //
                    } label: {
                        Text("close")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(myColor.textSecondary)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(myColor.textSecondary)
                            )
                            
                        
                    }
                    Button {
                        //
                    } label: {
                        Text("accept")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .background(myColor.primaryColor.cornerRadius(14))
                            
                        
                    }
                    
                  
                    

                }
                Spacer()
                
            }
            .padding()
            .presentationDetents([.medium])
        })
        .navigationTitle("coins")
        
    
      
    }
}

struct SettingAddCoinView_Previews: PreviewProvider {
    static var previews: some View {
        SettingAddCoinView()
    }
}
