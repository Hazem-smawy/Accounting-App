//
//  theme.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 05/06/2023.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var textFieldBind:String
    var placeHolder:String
    var body: some View {
        TextField(placeHolder , text: $textFieldBind)
            .multilineTextAlignment(.leading)
            .padding(10)
            .background(.thickMaterial)
            .cornerRadius(10)
            .customFont(size: 15)
    }
}
struct CustomMoneyField: View {
    @Binding var textFieldBind:String
    var formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
        formatter.currencyGroupingSeparator = ","
        formatter.groupingSize = 3
        formatter.formatWidth = 3
        formatter.alwaysShowsDecimalSeparator = true
            return formatter
        }()
    
    var placeHolder:String
    var body: some View {
        TextField( placeHolder, value: $textFieldBind,formatter:formatter)
        
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.leading)
            .padding(10)
            .background(.thickMaterial)
            .cornerRadius(10)
            .customFont(size: 15)
    }
}


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomMoneyField(textFieldBind: .constant("3234"), placeHolder: "name")
            .padding()
    }
}


struct CustomBtn:View {
    let color:Color
    let label:String
    let action:() -> Void
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                
                Text(label)
                    .customFont(size: 16,bold: true)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(color)
                    )
                
            }
        }
        
    }
}

struct TextModifier:ViewModifier {
    var size:CGFloat
    var bold:Bool
    func body(content: Content) -> some View {
        content
            .font(.custom(bold ? FontManager.Cairo.bold: FontManager.Cairo.regular, size: size))
        //.kerning(1)
    }
}

extension View {
    func customFont(size:CGFloat, bold:Bool = false) -> some View {
        self
            .modifier(TextModifier(size: size,bold: bold))
    }
}


struct CustomSittingBtn:View {
    let color:Color
    let label:String
    let action:() -> Void
    var body: some View {
        Button {
            action()
            
            
        } label: {
            Text(label)
                .customFont(size: 14,bold: true)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical,10)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color)
                )
            
        }
    }
}

struct ErrorView:View {
    let message:String
    
    var body: some View {
        HStack(spacing:10) {
            Image(systemName: "exclamationmark.triangle")
            
            Text(message)
            
                .customFont(size: 13)
            
        }
        
        .foregroundColor(.red)
        .padding(.horizontal)
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(height: 40)
        
        .background(RoundedRectangle(cornerRadius: 10).fill(.red.opacity(0.1)))
        .transition(.slide)
    }
}

struct CurrencyTextField: View {

    var title: String
    @Binding var value: Double
    
    @FocusState private var isFocused: Bool

    private let currencyNumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        return formatter
    }()

    private let decimalNumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false

        return formatter
    }()

    var body: some View {
        TextField(title, value: $value, formatter: isFocused ? decimalNumberFormatter : currencyNumberFormatter)
            .keyboardType(.decimalPad)
            .focused($isFocused)
    }
}
