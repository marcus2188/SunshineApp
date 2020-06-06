//
//  PracticeOverView.swift
//  SunshinePrototype
//
//  Created by MmmM on 29/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct ChallengeOverView: View {
    @EnvironmentObject var user : User
    @State var quitHome : Bool = false
    @State var replayPractice : Bool = false
    var practiceScore : Int
    
    init(sc : Int){
        self.practiceScore = sc
    }
    
    var body: some View {
        Group {
            if self.replayPractice{
                ChallengeGameView()
            }
            else if self.quitHome{
                HomeView()
            }
            else{
            ZStack {
                Image("menusun").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("\(self.user.profile.username), you obtained a score total of \(self.practiceScore) in Challenge Mode. ").bold().font(.system(size: 50)).foregroundColor(.black).padding(.all).border(Color.black, width: 2)
                    Spacer()
                    Button(action:{self.replayPractice = true}, label:{Text("Replay").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 3)
                    Button(action:{self.quitHome = true}, label:{Text("Quit").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 3).padding(.top, 50)
                    Spacer()
                    
                }
                }}
        }
    }
}

struct ChallengeOverView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeOverView(sc: 1).environmentObject(User())
    }
}

