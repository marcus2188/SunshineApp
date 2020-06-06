//
//  ReverseOverView.swift
//  SunshinePrototype
//
//  Created by MmmM on 31/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct ReverseOverView: View {
    @State var goHome : Bool = false
    @State var replayMode : Bool = false
    var score : Int
    
    init(time : Int){
        self.score = time
    }
    var body: some View {
        Group {
            if goHome{
                HomeView()
            }
            else if replayMode{
                ReverseGameView()
            }
            else{
            ZStack {
                Image("waves").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Image("judgment").resizable().frame(width:290, height: 290).padding(.all).border(Color.orange, width: 4)
                    Text("Judgment has failed you, but perhaps never again next time.").foregroundColor(.white).multilineTextAlignment(.leading).font(.system(size: 50)).foregroundColor(.black)
                    Spacer()
                    HStack {
                        Text("Reversi Time Record :").foregroundColor(.white).multilineTextAlignment(.leading).font(.system(size: 20)).foregroundColor(.black)
                        Text("\(self.score) seconds").bold().italic().foregroundColor(.blue).multilineTextAlignment(.leading).font(.system(size: 29)).foregroundColor(.black)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action:{self.replayMode = true}, label:{Text("Replay").bold().font(.system(size: 40)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 3)
                        Spacer()
                        Button(action:{self.goHome = true}, label:{Text("Quit").bold().font(.system(size: 40)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 3)
                        Spacer()
                    }
                }
                
                }}
        }
    }
}

struct ReverseOverView_Previews: PreviewProvider {
    static var previews: some View {
        ReverseOverView(time : 4)
    }
}
