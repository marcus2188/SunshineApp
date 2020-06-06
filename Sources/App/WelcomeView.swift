//
//  WelcomeView.swift
//  Kuchi
//
//  Created by MmmM on 27/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showloginscreen = false
    
    var body: some View {
        Group {
            if showloginscreen{
                RegisterView().environmentObject(User())
            }
            else{
                ZStack {
                    Image("sunjar").resizable().edgesIgnoringSafeArea([.top, .bottom])
                    VStack {
                        HStack {
                            Image("sun").resizable().frame(width : 80, height: 80)
                            VStack {
                                Text("Sunshine").bold().font(.system(size: 60)).foregroundColor(.white).lineLimit(2).multilineTextAlignment(.leading)
                                Text("\"Languages of the Sun\"").font(.headline).italic().foregroundColor(.black).lineLimit(1).multilineTextAlignment(.leading)
                            }
                        
                        }
                        Button(action: {self.showloginscreen = true}, label: {Text("Log In ").padding(.top, 290).foregroundColor(.yellow).font(.system(size: 30))})
                }
                }}
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
