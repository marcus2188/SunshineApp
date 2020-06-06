//
//  HomeView.swift
//  Kuchi
//
//  Created by MmmM on 28/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user : User
    @State private var moveToPractice : Bool = false
    @State private var moveToChallenge : Bool = false
    @State private var moveToReverse : Bool = false
    @State private var moveToLearn : Bool = false
    
    var body: some View {
        Group {
            if moveToPractice{
                PracticeView()
            }
            else if moveToChallenge{
                ChallengeView().environmentObject(ChallengeObject())
            }
            else if moveToReverse{
                ReverseView()
            }
            else if moveToLearn{
                LearnView()
            }
            else{
            ZStack {
                Image("menusun").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text(String("Hi, ") + self.user.profile.username).italic().font(.system(size: 50)).lineLimit(2).multilineTextAlignment(.leading).padding(.top, 150)
                    HStack {
                        Image("challengestar").resizable().frame(width: 60, height: 60)
                        Button(action:{self.moveToChallenge = true}, label:{Text("Challenge").bold().font(.largeTitle).foregroundColor(.black)})
                    }.padding(.top, 150)
                    HStack {
                        Image("practicecorona").resizable().frame(width: 60, height: 60)
                        Button(action:{self.moveToPractice = true}, label:{Text("Zen Mode").bold().font(.largeTitle).foregroundColor(.black)})
                    }.padding(.top, 20)
                    
                    HStack {
                        Image("progresscoin").resizable().frame(width: 60, height: 60)
                        Button(action:{self.moveToReverse = true}, label:{Text("Wrong One Out").bold().font(.largeTitle).foregroundColor(.black)})
                    }.padding(.top, 20)
                    HStack {
                        Image("profiler").resizable().frame(width: 60, height: 60)
                        Button(action:{self.moveToLearn = true}, label:{Text("Learn").bold().font(.largeTitle).foregroundColor(.black)})
                    }.padding(.top, 20)
                    HStack {
                        Text(""); Image("settingsicon").resizable().frame(width: 60, height: 60).padding(.leading, 300)
                    }.padding(.all, 20)
                }
                }}
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let previewer = User(uname: "Lewis Ham", pas: "asdfghjkkl")
    static var previews: some View {
        HomeView().environmentObject(previewer)
    }
}
