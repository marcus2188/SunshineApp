import Foundation
import Combine

class TimerObject: ObservableObject{
    let willChange = PassthroughSubject<TimerObject, Never>()
    var timer : Timer?
    var counter : Int = 0
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter(){
        counter += 1
        willChange.send(self)
    }
    func killTimer(){
        timer?.invalidate()
        timer = nil
    }
}
