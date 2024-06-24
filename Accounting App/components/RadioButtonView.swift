//
//  RadioButtonView.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 05/06/2023.
//

import SwiftUI
struct ListOfRadioButtonView :View {
   
    @State private var curencies:[Curency] = []
    @EnvironmentObject var vm :AccountingAppViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(curencies, id: \.self){ option in
                RadioButtonView(label: option.curencyName ?? "", isSelected: option.curencyName == vm.currentCurency?.curencyName) {
                    withAnimation {
                        
                        vm.isError = nil
                    }

                    vm.currentCurency = option
                    
                }
            }
        }
        .onAppear {
            withAnimation {

                curencies = vm.curences.filter({$0.status})
            }
        }
    }
}

struct RadioButtonView: View {
    let label:String
    let isSelected:Bool
    let action:() -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
               
                Image(systemName: isSelected ? "largecircle.fill.circle":"circle")
                    .resizable()
                    .frame(width: 20,height: 20)
                Text(label)
                    .customFont(size: 13)
                
            }
        }
        .foregroundColor(isSelected ? .blue : myColor.textSecondary)

    }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfRadioButtonView()
    }
}
