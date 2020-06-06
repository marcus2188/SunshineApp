import SwiftUI
import Combine

struct ReverseView: View {
    @State private var enterGame : Bool = false
    @State private var quitGame : Bool = false
    
    var body: some View {
        Group {
            if enterGame{
                ReverseGameView()
            }
            else if quitGame{
                HomeView()
            }
            else{
            ZStack {
                Image("menusun").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("We put together 6 questions with their answers. One of them is a liar. Pick the wrong one out within the time limit, and survive as long as you can.").font(.system(size: 50)).foregroundColor(.black).padding(.all)
                    Spacer()
                    Button(action:{self.enterGame = true}, label:{Text("PLAY").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 5)
                    Button(action:{self.quitGame = true}, label:{Text("QUIT").bold().font(.system(size: 50)).foregroundColor(.white)}).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(Color.white, width: 5).padding(.top)
                }
                }}
        }
    }
}

struct ReverseView_Previews: PreviewProvider {
    static var previews: some View {
        ReverseView()
    }
}
