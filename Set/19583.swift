import Foundation

extension String {
    func timeTup() -> (Int, Int) {
        let timeArr = self.split(separator: ":").map{ Int($0)! }
        return (timeArr[0], timeArr[1])
    }
}

let sStudent: [String] = []
let fStudent: [String] = []

let inputTime = readLine()!
let splitedTime = inputTime.split(separator: " ")
let S: (Int, Int) = String(splitedTime[0]).timeTup()
let E: (Int, Int) = String(splitedTime[1]).timeTup()
let Q: (Int, Int) = String(splitedTime[2]).timeTup()

var sSet: Set<String> = []
var eSet: Set<String> = []

while let log = readLine() {
    if log == "" || log == "\n" { break }
    let temInput = log.split(separator: " ")
    let curTime  = String(temInput[0]).timeTup()
    
    if curTime <= S {
        sSet.insert(String(temInput[1]))
    } else if curTime >= E && curTime <= Q  {
        eSet.insert(String(temInput[1]))
    }
}

print(eSet.intersection(sSet).count)
