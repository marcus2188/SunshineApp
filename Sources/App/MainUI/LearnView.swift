import SwiftUI
import Combine

struct LearnView: View {
    @ObservedObject var myjsonobj : Json = Json()
    private var languageList = ["All words", "Korean", "Japanese", "Spanish", "Chinese", "None"]
    @State var curList : [challenge] = [challenge(question: "<Question Card>", pronunciation: "Pronunciation", answer: "Answer", language: "gg")]
    @State private var curTab : Int = 5
    @State var goHome : Bool = false
    
    var body: some View {
        Group {
            if goHome{
                HomeView()
            }
            else{
            ZStack {
                Image("fields").resizable().edgesIgnoringSafeArea([.top, .bottom]).blur(radius: 2)
                HStack {
                    VStack {
                        ForEach(0..<self.languageList.count){index in
                            Button(action:{self.curTab = index;self.changeList()}, label:{Text(self.languageList[index]).font(.system(size: 20)).foregroundColor(.black).padding(EdgeInsets(top:8,leading:16,bottom:8,trailing:16)).background(RoundedRectangle(cornerRadius: 20).fill(self.curTab == index ? Color.orange : Color.white)).padding(.top, 20)})
                            
                        }
                        Button(action:{self.goHome = true}, label:{Text("BB")}).background(Image("back").resizable().frame(width:60, height: 60)).padding(.top, 200)
                    }
                    Divider()
                    VStack {
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(0..<self.curList.count) {index in
                                    VStack {
                                        Text(self.curList[index].question)
                                        Text(self.curList[index].pronunciation)
                                        Text(self.curList[index].answer)
                                    }.foregroundColor(.black).font(.headline).frame(width: 250, height: 150).background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                }.id(self.curList.count)
                            }
                        }
                    }
                }
                }}
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
extension LearnView{
    func changeList(){
        if curTab == 0{
            self.curList = self.myjsonobj.chalist
        }
        else if curTab == 1{
            self.curList = self.myjsonobj.chalist.filter{ $0.language == "kor"
            }
        }
        else if curTab == 2{
            self.curList = self.myjsonobj.chalist.filter{ $0.language == "jap"
            }
        }
        else if curTab == 3{
            self.curList = self.myjsonobj.chalist.filter{ $0.language == "spa"
            }
        }
        else if curTab == 4{
            self.curList = self.myjsonobj.chalist.filter{ $0.language == "chi"
            }
        }
        else if curTab == 5{
            self.curList = []
            
        }
    }
}
