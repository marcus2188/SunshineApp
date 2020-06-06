//
//  testerjsonview.swift
//  SunshinePrototype
//
//  Created by MmmM on 4/6/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI
import Combine

struct testerjsonview: View {
    @ObservedObject var jsonobj : Json = Json()
    @State private var ccs : [cc] = []
    @State private var chs : [ch] = []
    
    var body: some View {
        ZStack {
            Image("menusun").onAppear{
                API().getDataOnline{(ccs) in
                    self.ccs = ccs
                }
                API().getLocalData{(chs) in
                    self.chs = chs
                }
            }
            VStack {
                ForEach(jsonobj.chalist){challenge in
                    Text("\(challenge.answer)")
                }
            }
        }
    }
}

struct testerjsonview_Previews: PreviewProvider {
    static var previews: some View {
        testerjsonview()
    }
}
