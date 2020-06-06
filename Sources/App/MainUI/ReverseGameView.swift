import SwiftUI
import Combine

struct ReverseGameView: View {
    @ObservedObject var myjsonobj = Json()
    @State var randomIndex : Int = Int.random(in: 0..<6)
    @State var answerCorrect : Bool = false
    @State var answerWrong : Bool = false
    @State var chosenANS : Int = 0
    @State var gameover : Bool = false
    @State var curWrongOneOutPane = wrongOneOutPane(curChallengelist: [challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "right ans", language: "gg"), challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "right ans", language: "gg"), challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "right ans", language: "gg"), challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "right ans", language: "gg"), challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "right ans", language: "gg"), challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "right ans", language: "gg")], wrongans: "I'm WRONG")
    @State var timeLeft : Int = 15
    @State var initTime : Int = 10
    @State var globalTime : Int = 0
    @State var timer = Timer.publish(every: 1.3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group {
            if self.gameover{
                ReverseOverView(time : globalTime)
            }
            else{
            ZStack {
                Image("wall").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("WRONG ONE OUT").bold()
                        .font(.largeTitle)
                    Text("\(timeLeft)").font(.title).onReceive(timer) {_ in if self.timeLeft > 0{
                    self.timeLeft -= 1
                    }else if self.timeLeft==0{
                        self.gameover = true
                        }}
                    HStack {
                        Spacer()
                        Button(action:{self.chosenANS = 0;self.checkAnswerANDSet()}, label:{
                            VStack {
                                Text(curWrongOneOutPane.curChallengelist[0].question).foregroundColor(.black)
                            Text(curWrongOneOutPane.curChallengelist[0].pronunciation).foregroundColor(.black)
                                Text(self.randomIndex==0 ? curWrongOneOutPane.wrongans : curWrongOneOutPane.curChallengelist[0].answer).foregroundColor(.black)
                            }}).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).border(Color.black, width: 4).font(.system(size: 20))
                        Spacer()
                        Button(action:{self.chosenANS = 1;self.checkAnswerANDSet()}, label:{
                        VStack {
                        Text(curWrongOneOutPane.curChallengelist[1].question).foregroundColor(.black)
                        Text(curWrongOneOutPane.curChallengelist[1].pronunciation).foregroundColor(.black)
                         Text(self.randomIndex==1 ? curWrongOneOutPane.wrongans : curWrongOneOutPane.curChallengelist[1].answer).foregroundColor(.black)
                        }}).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).border(Color.black, width: 4).font(.system(size: 20))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action:{self.chosenANS = 2;self.checkAnswerANDSet()}, label:{
                            VStack {
                            Text(curWrongOneOutPane.curChallengelist[2].question).foregroundColor(.black)
                            Text(curWrongOneOutPane.curChallengelist[2].pronunciation).foregroundColor(.black)
                             Text(self.randomIndex==2 ? curWrongOneOutPane.wrongans : curWrongOneOutPane.curChallengelist[2].answer).foregroundColor(.black)
                            }}).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).border(Color.black, width: 4).font(.system(size: 20))
                        Spacer()
                        Button(action:{self.chosenANS = 3;self.checkAnswerANDSet()}, label:{
                        VStack {
                        Text(curWrongOneOutPane.curChallengelist[3].question).foregroundColor(.black)
                        Text(curWrongOneOutPane.curChallengelist[3].pronunciation).foregroundColor(.black)
                         Text(self.randomIndex==3 ? curWrongOneOutPane.wrongans : curWrongOneOutPane.curChallengelist[3].answer).foregroundColor(.black)
                        }}).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).border(Color.black, width: 4).font(.system(size: 20))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action:{self.chosenANS = 4;self.checkAnswerANDSet()}, label:{
                            VStack {
                            Text(curWrongOneOutPane.curChallengelist[4].question).foregroundColor(.black)
                            Text(curWrongOneOutPane.curChallengelist[4].pronunciation).foregroundColor(.black)
                             Text(self.randomIndex==4 ? curWrongOneOutPane.wrongans : curWrongOneOutPane.curChallengelist[4].answer).foregroundColor(.black)
                            }}).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).border(Color.black, width: 4).font(.system(size: 20))
                        Spacer()
                        Button(action:{self.chosenANS = 5;self.checkAnswerANDSet()}, label:{
                        VStack {
                        Text(curWrongOneOutPane.curChallengelist[5].question).foregroundColor(.black)
                        Text(curWrongOneOutPane.curChallengelist[5].pronunciation).foregroundColor(.black)
                         Text(self.randomIndex==5 ? curWrongOneOutPane.wrongans : curWrongOneOutPane.curChallengelist[5].answer).foregroundColor(.black)
                        }}).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).border(Color.black, width: 4).font(.system(size: 20))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text("Reversi Time Record").foregroundColor(Color.white)
                        Text("\(globalTime)").font(.largeTitle).foregroundColor(Color.blue).onReceive(timer) {_ in
                            self.globalTime += 1
                        }
                    }.padding(.top)
                    Button(action:{self.resetPane()}, label:{Text(self.answerWrong ? "Time for judgement for continuing, click here. " : self.answerCorrect ? "Correct!, click here to move on" : "WHICH ONE IS THE LIAR ?").font(.system(size: 40)).foregroundColor(self.answerWrong ? .red : self.answerCorrect ? .green : .gray).padding(.all).multilineTextAlignment(.center)}).border(self.answerWrong ? Color.red : self.answerCorrect ? Color.green : Color.gray, width: 3)
                    
                
                }
                
                }}
        }
    }
}

struct ReverseGameView_Previews: PreviewProvider {
    static var previews: some View {
        ReverseGameView()
    }
}

extension ReverseGameView{
    // check if selected button is correct in pane
    func checkAnswerANDSet(){
        if chosenANS == randomIndex{
            self.answerCorrect = true
        }
        else {
            self.answerWrong = true
        }
        self.timer.upstream.connect().cancel()
    }
    func judgement(){
        // 2/3 chance to be judged and eliminated
        let luckyNum = Int.random(in: 0...2)
        if luckyNum == 1{
            self.gameover = true
        }
    }
    func resetPane(){
        if self.answerWrong{ // answer wrong
            self.judgement()
            self.timeLeft += 2
        }
        else if self.answerCorrect{ // answer correct
            self.timeLeft += 7
        }
        else{ // run out of game time
            self.judgement()
            self.timeLeft += 7
        }
        self.timer = Timer.publish(every: 1.3, on: .main, in: .common).autoconnect()
        self.randomIndex = Int.random(in: 0..<6)
        self.answerWrong = false
        self.answerCorrect = false
        self.curWrongOneOutPane = self.getRandomWrongOneOutPane()
        while self.curWrongOneOutPane.curChallengelist[self.randomIndex].answer == self.curWrongOneOutPane.wrongans{
            self.randomIndex = Int.random(in: 0..<6)
        }
    }
    func getRandomWrongOneOutPane() -> wrongOneOutPane{
        self.myjsonobj.clonedChallengeModeList.shuffle()
        var chosen6 : [challenge] = []
        for _ in 0..<6{
        chosen6.append(self.myjsonobj.clonedChallengeModeList.removeFirst())
        }
        let otherans : String = self.myjsonobj.clonedChallengeModeList.randomElement()!.answer
        self.myjsonobj.clonedChallengeModeList = self.myjsonobj.chalist
        return wrongOneOutPane(curChallengelist: chosen6, wrongans: otherans)
    }
}
