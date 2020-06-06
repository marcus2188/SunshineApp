//
//  PracticeView.swift
//  SunshinePrototype
//
//  Created by MmmM on 28/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct PracticeView: View {
    @State private var enterGame : Bool = false
    @State private var quitGame : Bool = false
    
    var body: some View {
        Group {
            if enterGame{
                PracticeGameView()
            }
            else if quitGame{
                HomeView()
            }
            else{
            ZStack {
                Image("menusun").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("Zen Mode lets you to practice foreign languages with a total of 10 questions, no time limit and question repetitions are  allowed.").font(.system(size: 50)).foregroundColor(.black).padding(.all)
                    Spacer()
                    Button(action:{self.enterGame = true}, label:{Text("PLAY").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 5)
                    Button(action:{self.quitGame = true}, label:{Text("QUIT").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 5).padding(.top)
                }
                }}
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
