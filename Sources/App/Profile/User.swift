import Foundation
import Combine

final internal class User : ObservableObject{
    @Published var isregistered : Bool = false   // notification to subscribers
    let willchange = PassthroughSubject<User, Never>()
    var profile : Profile = Profile(){
        willSet{
            willchange.send(self)
        }
    }
    
    init(uname:String, pas:String){
        self.profile.username = uname
        self.profile.password = pas
    }
    init(){}
}
