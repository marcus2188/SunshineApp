//
//  PracticeView.swift
//  SunshinePrototype
//
//  Created by MmmM on 28/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {
    @State private var enterGame : Bool = false
    @State private var quitGame : Bool = false
    init() {
    }
    var body: some View {
        Group {
            if enterGame{
                ChallengeGameView()
            }
            else if quitGame{
                HomeView()
            }
            else{
            ZStack {
                Image("menusun").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("Challenge Mode puts your foreign language skills to it's limit. Survive the quiz with 3 lives only. No repetitions allowed.").font(.system(size: 50)).foregroundColor(.black).padding(.all)
                    HStack {
                        Image("challengestar").resizable().frame(width: 60, height: 60)
                        Image("challengestar").resizable().frame(width: 60, height: 60)
                        Image("challengestar").resizable().frame(width: 60, height: 60)
                    }
                    Spacer()
                    Button(action:{self.enterGame = true}, label:{Text("PLAY").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 5)
                    Button(action:{self.quitGame = true}, label:{Text("QUIT").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 5).padding(.top)
                }
                }}
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}

