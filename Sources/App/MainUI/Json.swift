import Foundation
import SwiftUI
import Combine

struct challenge : Codable, Identifiable {
    enum CodingKeys : CodingKey{
        case question
        case pronunciation
        case answer
        case language
    }
    let id = UUID()
    let question : String
    let pronunciation : String
    let answer : String
    let language : String
    
    func hash(into hasher: inout Hasher) {
      question.hash(into: &hasher)
    }
}
struct challengerPane {
    let curChallenge : challenge
    let answerchoice : [String]
    func isAnswerCorrect(ans:String) -> Bool{
        return curChallenge.answer == ans
    }
}
struct wrongOneOutPane {
    let curChallengelist : [challenge]
    let wrongans : String
    func isitcorrect(ch:challenge, ans:String) -> Bool{
        return ch.answer != ans
    }
}
class Json : ObservableObject{
    @Published var chalist = [challenge]()
    @Published var clonedChallengeModeList = [challenge]()
    
    init() {
        loadJSON()
    }
    func loadJSON() {
        let path = Bundle.main.path(forResource: "MASTERLIST", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        URLSession.shared.dataTask(with: url){(data, response, error) in
            let chas = try! JSONDecoder().decode([challenge].self, from: data!)
            DispatchQueue.main.async {
                self.chalist = chas
                self.clonedChallengeModeList = chas
            }
            
        
        }.resume()
    }
}
