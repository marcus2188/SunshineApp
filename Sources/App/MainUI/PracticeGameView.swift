//
//  PracticeGameView.swift
//  SunshinePrototype
//
//  Created by MmmM on 29/5/20.
import SwiftUI

struct PracticeGameView: View {
    @ObservedObject var myjsonobj = Json()
    @State var curPane : challengerPane = challengerPane(curChallenge: challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "click", language: "gg"), answerchoice: ["click", "click", "click", "click"])
    @State var answerCorrect : Bool = false
    @State var answerWrong : Bool = false
    @State var numOfGames : Int = 0
    @State var currentScore : Int = 0
    var gamelimit : Int = 10
    
    var body: some View {
        Group {
            if self.numOfGames == gamelimit{
                PracticeOverView(sc: currentScore, tn: numOfGames)
            }
            else{
            ZStack {
                Image("sunmountain").resizable().edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Text("QN : \(numOfGames+1)").font(.title).bold().foregroundColor(self.answerWrong ? .red : self.answerCorrect ? .green : .black)
                    Spacer()
                    ZStack {
                        Image("menusun").resizable().padding(.all).opacity(0.3); VStack {
                            Text(curPane.curChallenge.question).bold().font(.system(size: 60))
                            Text(curPane.curChallenge.pronunciation).font(.system(size: 30))
                            if answerCorrect{
                                Button(action:{self.resetVariablesAndNext()
                                }, label:{Text("You're Right, Next ->").disabled(!answerCorrect)})
                            }
                            else if answerWrong{
                                Button(action:{self.resetVariablesAndNext()
                                }, label:{Text("You're Wrong, Next ->").disabled(!answerWrong)})
                            }
                        }
                    }
                    Spacer()
                    ForEach(0..<4){index in
                        Button(action:{self.checkAnswerAndSet(selectedAnswer: self.curPane.answerchoice[index])}, label:{Text(String(self.curPane.answerchoice[index])).bold().font(.system(size: 30)).foregroundColor(.white).padding(EdgeInsets(top:8, leading:16, bottom:8, trailing:16)).border(self.answerWrong || self.answerCorrect ? self.curPane.isAnswerCorrect(ans: self.curPane.answerchoice[index]) ? Color.green : Color.red : Color.white, width: 4)})
                        Divider()
                    }
                }
                }}
        }
    }
}

struct PracticeGameView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeGameView()
    }
}
extension PracticeGameView{
    // check the selected button answer and set truth colour, bool
    func checkAnswerAndSet(selectedAnswer : String){
        if curPane.isAnswerCorrect(ans: selectedAnswer){
            self.answerCorrect = true
            self.currentScore += 1
        }
        else{
            self.answerWrong = true
        }
    }
    func resetVariablesAndNext(){
        self.numOfGames += 1
        self.answerCorrect = false
        self.answerWrong = false
        self.curPane = self.getRandomPracticeChallengerPane()
    }
    func getRandomPracticeChallengerPane() -> challengerPane{
        let selectedRandomChallenge = self.myjsonobj.chalist.randomElement()!
        let selectedRandomChallengerPane = challengerPane(curChallenge: selectedRandomChallenge, answerchoice: get3RandomAnswersPracticeIncludeCurrent(curAns: selectedRandomChallenge.answer))
        return selectedRandomChallengerPane
    }
    func get3RandomAnswersPracticeIncludeCurrent(curAns : String) -> [String]{
        var randomAnswersArray = Set<String>()
        randomAnswersArray.insert(curAns)
        var answerlist : [String]{return self.myjsonobj.chalist.map{$0.answer}}
        while randomAnswersArray.count < 4{
            randomAnswersArray.insert(answerlist.randomElement()!)
        }
        return Array(randomAnswersArray).shuffled()
    }
}
