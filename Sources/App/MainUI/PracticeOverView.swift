//
//  PracticeOverView.swift
//  SunshinePrototype
//
//  Created by MmmM on 29/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct PracticeOverView: View {
    @EnvironmentObject var user : User
    @State var quitHome : Bool = false
    @State var replayPractice : Bool = false
    var practiceScore : Int
    var totalno : Int
    
    init(sc : Int, tn : Int){
        self.practiceScore = sc
        self.totalno = tn
    }
    
    var body: some View {
        Group {
            if self.replayPractice{
                PracticeGameView()
            }
            else if self.quitHome{
                HomeView()
            }
            else{
            ZStack {
                Image("menusun").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("\(self.user.profile.username), you obtained a score total of \(self.practiceScore) out of \(self.totalno) games in Practice Mode. That is a good old " + String(format: "%.0f", Double(self.practiceScore)/Double(self.totalno) * 100) + "%.").bold().font(.system(size: 50)).foregroundColor(.black).padding(.all).border(Color.black, width: 2)
                    Spacer()
                    Button(action:{self.replayPractice = true}, label:{Text("Replay").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 3)
                    Button(action:{self.quitHome = true}, label:{Text("Quit").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 3).padding(.top, 50)
                    Spacer()
                    Text(self.practiceScore <= self.totalno/2 ? "Failure is the ... you know the drill" : "Passed with flying colours, literally").italic().font(.headline).bold().foregroundColor(.white)
                    
                }
                }}
        }
    }
}

struct PracticeOverView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeOverView(sc: 1, tn: 3).environmentObject(User())
    }
}
