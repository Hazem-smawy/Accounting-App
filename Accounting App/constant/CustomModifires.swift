//
//  CustomModifires.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 31/05/2023.
//

import Foundation
import SwiftUI

struct ShadowModifire : ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: myColor.shadowColor, radius: 10)
    }
}


extension View {
    func customShadow() -> some View {
        modifier(ShadowModifire())
    }
}
