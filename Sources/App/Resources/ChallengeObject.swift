import Foundation
import SwiftUI
import Combine

// Definition of each Challenge in master list of data
struct Challenge : Codable{
    let question: String
    let pronunciation: String
    let answer: String
    let language: String
    var completed: Bool = false
    var succeeded: Bool = false
    
    func hash(into hasher: inout Hasher) {
      question.hash(into: &hasher)
    }
}
// Single challenge pane, checks correct anot
struct challengePane {
    let challenge : Challenge
    let answerchoice : [String]
    func isAnswerCorrect(ans:String) -> Bool{
        return challenge.answer == ans
    }
}
struct reversiPane {
    let challengelist : [Challenge]
    let wrongans : String
    func isitcorrect(ch:Challenge, ans:String) -> Bool{
        return ch.answer != ans
    }
}

class ChallengeObject : ObservableObject{
    @Published var currentChallengePane : challengePane?
    @Published var currentReversiPane : reversiPane?
    var selectedRandomChallenge : Challenge?
    var clonedmasterlist : [Challenge]
    var challengeMasterList : [Challenge] = []
    // initialise with a random challengepane first
    init() {
        self.currentReversiPane = reversiPane(challengelist: [Challenge(question: "<SAMPLE QUESTION>", pronunciation: "Choose any 1", answer: "Right ans", language: "none"),Challenge(question: "<FREE QUESTION>", pronunciation: "Choose any 1", answer: "Right ans", language: "none"),Challenge(question: "<FREE QUESTION>", pronunciation: "Choose any 1", answer: "Right ans", language: "none"),Challenge(question: "<FREE QUESTION>", pronunciation: "Choose any 1", answer: "Right ans", language: "none"),Challenge(question: "<FREE QUESTION>", pronunciation: "Choose any 1", answer: "Right ans", language: "none"),Challenge(question: "<FREE QUESTION>", pronunciation: "Choose any 1", answer: "Right ans", language: "none")], wrongans: "THIS ANS WRONG")
        self.currentChallengePane = challengePane(challenge: Challenge(question: "<FREE QUESTION>", pronunciation: "Choose any 1", answer: "TAP HERE", language: "none"), answerchoice: ["TAP HERE", "TAP HERE", "TAP HERE", "TAP HERE"])
        
        var ff_: Any?
        if let path = Bundle.main.path(forResource: "MASTERLIST", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                ff_ = try JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        for x in (ff_ as? [[String:AnyObject]])!{
            self.challengeMasterList.append(Challenge(question: x["question"] as! String, pronunciation: x["pronunciation"] as! String, answer: x["answer"] as! String, language: x["language"] as! String))
        }
        self.clonedmasterlist = challengeMasterList
    }
    var answerMasterList : [String] {return challengeMasterList.map{
        $0.answer
        }}
    var correctanswerslist : [Challenge] = []
    var wronganswerslist : [Challenge] = []     // list of all answered challenge that user answered right or wrong dependingly
    
}

extension ChallengeObject{
    // get a random uncompleted challenge pane and return it
    func getRandomChallenge() -> challengePane?{
        if clonedmasterlist.isEmpty{
            return challengePane(challenge: Challenge(question: "out", pronunciation: "Choose 1 ans", answer: "TAP HERE", language: "none"), answerchoice: ["TAP HERE", "TAP HERE", "TAP HERE", "TAP HERE"]) // completed all questions liao
        }
        else{
            clonedmasterlist.shuffle()
            selectedRandomChallenge = clonedmasterlist.removeFirst()
        }
        let selectedchallengePane = selectedRandomChallenge.map({
            challengePane(challenge: $0, answerchoice: get3RandomAnswers(currentAnswer : $0.answer))
        })
        return selectedchallengePane
    }
    // generate array of 3 + 1 random answers
    func get3RandomAnswers(currentAnswer:String) -> [String]{
        var randomAnswersArray = Set<String>()
        randomAnswersArray.insert(currentAnswer)
        while randomAnswersArray.count < 4{
            randomAnswersArray.insert(answerMasterList.randomElement()!)
        }
        return Array(randomAnswersArray).shuffled()
        
    }
    // Change or iterate the current challenge pane displayed to player
    func changeCurrentChallengePane(){
        self.currentChallengePane = self.getRandomChallenge()
    }
    
    // Save all the correct and wrong answers so far
    func saveCorrectAnswer(challenge : Challenge){
        self.correctanswerslist.append(challenge)
    }
    func saveWrongAnswer(challenge : Challenge){
        self.wronganswerslist.append(challenge)
    }
    
    // Restart the game entirely
    func restartgame(){
        self.correctanswerslist = []
        self.wronganswerslist = []
        self.changeCurrentChallengePane()
    }
    
    // Reversi mode generate 6 challenge array
    func getRandomChallengeArray() -> reversiPane?{
        clonedmasterlist.shuffle()
        var chosen6 : [Challenge] = []
        for _ in 0..<6{
            chosen6.append(clonedmasterlist.removeFirst())
        }
        let otherans : String = clonedmasterlist.randomElement()!.answer
        clonedmasterlist = self.challengeMasterList
        return reversiPane(challengelist: chosen6, wrongans: otherans)
    }
    // change current reversi pane
    func changeCurrentReversiPane(){
        self.currentReversiPane = getRandomChallengeArray()
    }
    
    func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    func save(jsonObject: Any, toFilename filename: String) throws{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: fileURL, options: [.atomicWrite])
            
        }
        
    }
    func saver(){
        var jsonData: NSData!
        // serialize json dataa
        do
        {
            jsonData = try JSONSerialization.data(withJSONObject: ["hi":"bye", "jy":"ip"], options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            print(jsonString!)
        }
        catch let error as NSError
        {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }

        // overwrite the contents of the original file.
        do
        {
            let path = Bundle.main.path(forResource: "2", ofType: "json")
            let deurl = URL(fileURLWithPath: path!)
            let file = try FileHandle(forWritingTo: deurl)
            file.write(jsonData as Data)
                print("JSON data was written to the file successfully!")
        }
        catch let error as NSError
        {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
        
    }
}
