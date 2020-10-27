import Foundation

let inputArr = readLine()!.split(separator: " ").map{ Int($0)! }
let N = inputArr[0]
var K = inputArr[1]


var valueArr: [Int] = []
var maxIdx = 0
for i in 0..<N {
    let temVar = readLine().map{ Int($0)! }!
    valueArr.append(temVar)
    if temVar <= K {
        maxIdx = i
    }
}

var ans = 0
for i in 0...maxIdx {
    if K < valueArr[maxIdx - i] {
        continue
    }
    let temCount = K/valueArr[maxIdx - i]
    ans += temCount
    K = K % (valueArr[maxIdx - i] * temCount)
}
print(ans)
