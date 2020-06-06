//
//  PracticeGameView.swift
//  SunshinePrototype
//
//  Created by MmmM on 29/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct ChallengeGameView: View {
    @ObservedObject var myjsonobj = Json()
    @State var curPane : challengerPane = challengerPane(curChallenge: challenge(question: "<Free Point>", pronunciation: "sample qn", answer: "click", language: "gg"), answerchoice: ["click", "click", "click", "click"])
    @State var answerCorrect : Bool = false
    @State var answerWrong : Bool = false
    @State var numOfLivesLeft : Int = 3
    @State var currentScore : Int = 0
    
    var body: some View {
        Group {
            if self.numOfLivesLeft == 0{
                ChallengeOverView(sc: currentScore)
            }
            else{
            ZStack {
                Image("sunmountain").resizable().edgesIgnoringSafeArea([.top, .bottom]).onAppear{
                }
                VStack {
                    HStack {
                        VStack {
                            Text("Score")
                                .font(.headline)
                            Text(String(self.currentScore))
                                .font(.title)
                        }
                        Image("challengestar").resizable().frame(width: 60, height: 60).opacity(self.numOfLivesLeft <= 0 ? 0 : 1)
                        Image("challengestar").resizable().frame(width: 60, height: 60).opacity(self.numOfLivesLeft <= 1 ? 0 : 1)
                        Image("challengestar").resizable().frame(width: 60, height: 60).opacity(self.numOfLivesLeft <= 2 ? 0 : 1)
                        VStack {
                            Text("Life left:").font(.headline)
                            Text(String(self.numOfLivesLeft)).font(.title)
                        }
                    }
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

struct ChallengeGameView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeGameView()
    }
}
extension ChallengeGameView{
    // check the selected button answer and set truth colour, bool
    func checkAnswerAndSet(selectedAnswer : String){
        if curPane.isAnswerCorrect(ans: selectedAnswer){
            self.answerCorrect = true
            self.currentScore += 1
        }
        else{
            self.numOfLivesLeft -= 1;
            self.answerWrong = true
        }
    }
    func resetVariablesAndNext(){
        self.answerCorrect = false
        self.answerWrong = false
        self.curPane = self.getRandomChallengeChallengerPane()
        if self.curPane.curChallenge.question == "out"{
            self.numOfLivesLeft = 0
        }
    }
    func getRandomChallengeChallengerPane() -> challengerPane{
        self.myjsonobj.clonedChallengeModeList.shuffle()
        let selectedRandomChallenge = self.myjsonobj.clonedChallengeModeList.removeFirst()

        let selectedRandomChallengerPane = challengerPane(curChallenge: selectedRandomChallenge, answerchoice: get3RandomAnswersChallengeIncludeCurrent(curAns: selectedRandomChallenge.answer))
        return selectedRandomChallengerPane
    }
    func get3RandomAnswersChallengeIncludeCurrent(curAns : String) -> [String]{
        var randomAnswersArray = Set<String>()
        randomAnswersArray.insert(curAns)
        var answerlist : [String]{return self.myjsonobj.chalist.map{$0.answer}}
        
        while randomAnswersArray.count < 4{
            randomAnswersArray.insert(answerlist.randomElement()!)
        }
        return Array(randomAnswersArray).shuffled()
    }
}

