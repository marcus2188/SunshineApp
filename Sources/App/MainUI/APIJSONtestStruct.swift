import Foundation
import SwiftUI

struct cc : Codable, Identifiable{
    let id = UUID()
    let title : String
    let body : String
}
struct ch : Codable, Identifiable {
    let id = UUID()
    let question : String
    let pronunciation : String
    let answer : String
    let language : String
}
class API {
    func getDataOnline(completion: @escaping ([cc]) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            return
        }
        URLSession.shared.dataTask(with: url){(data, _, _) in
            let ccs = try! JSONDecoder().decode([cc].self, from: data!)
            DispatchQueue.main.async {
                completion(ccs)
            }
        }.resume()
    }
    func getLocalData(completion: @escaping ([ch]) -> ()){
        let path = Bundle.main.path(forResource: "MASTERLIST", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        URLSession.shared.dataTask(with: url){(data, response, error) in
            let chs = try! JSONDecoder().decode([ch].self, from: data!)
            DispatchQueue.main.async {
                completion(chs)
            }
        }.resume()
    }
}

