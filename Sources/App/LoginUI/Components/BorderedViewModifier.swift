//
//  BorderedViewModifier.swift
//  SunshinePrototype
//
//  Created by MmmM on 28/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
    func body(content : Content) -> some View {
        content.border(Color.gray).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).multilineTextAlignment(.center).foregroundColor(.white)
    }
}
extension View{
    func textfieldbordered() -> some View{
        ModifiedContent(
            content:self,modifier: BorderedViewModifier()
        )
        
    }
}
