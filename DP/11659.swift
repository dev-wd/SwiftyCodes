import Foundation

let nm = readLine()!.split(separator: " ").map{ Int($0)! }
let N = nm[0]
let M = nm[1]

let matrix = readLine()!.split(separator: " ").map{ Int($0)! }
var ansMatrix :[Int] = []

for i in 0..<matrix.count {
    if i == 0 {
        ansMatrix.append(0)
        ansMatrix.append(matrix[i])
    } else {
        ansMatrix.append(matrix[i]+ansMatrix.last!)
    }
}

for _ in 0..<M {
    let tem = readLine()!.split(separator: " ").map{ Int($0)! }
    print(ansMatrix[tem[1]] - ansMatrix[tem[0]-1])
}
