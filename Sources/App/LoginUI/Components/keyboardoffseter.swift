//
//  keyboardoffseter.swift
//  SunshinePrototype
//
//  Created by MmmM on 28/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import Foundation
import SwiftUI

struct keyboard : ViewModifier {
    @State var offsetval : CGFloat = 0
    func body(content: Content) -> some View {
        content.padding(.bottom, offsetval).onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){
                (notification) in
                let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.offsetval = height
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){
                (notification) in
                self.offsetval = 0
            }
        }
    }
}
extension View{
    func keyboardoffsetter() -> some View{
        ModifiedContent(content: self, modifier: keyboard())
    }
}
