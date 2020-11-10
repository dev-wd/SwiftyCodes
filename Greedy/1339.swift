import Foundation

let N = Int(readLine()!)!
var matrix :[[String]] = Array(repeating: Array(repeating: " ", count: N), count: 8)
var alphabets: Set<String> = []
var calculateList: [String] = []
for i in 0..<N {
    let tem = readLine()!
    calculateList.append(tem)
    for j in 0..<tem.count {
        let curTem = String(tem[tem.index(tem.startIndex, offsetBy: j)])
        matrix[8 - (tem.count - j)][i] = curTem
        alphabets.insert(curTem)
    }
}

var alphabetsPriority:[(String, Double)] = []
alphabets.forEach { alphabetsPriority.append(($0,0)) }

for i in 0..<matrix.count {
    for j in 0..<matrix[0].count {
        let curAlphabet = matrix[i][j]
        if curAlphabet != " " {
            for k in 0..<alphabetsPriority.count {
                if alphabetsPriority[k].0 == curAlphabet {
                    alphabetsPriority[k].1 += pow(0.1, Double(i))
                }
            }
        }
    }
}

alphabetsPriority.sort(by: { $0.1 > $1.1 })
var count:Double = 9
for i in 0..<alphabetsPriority.count {
    alphabetsPriority[i].1 = count
    count -= 1
}


var ansSheet :[Int] = []
for i in 0..<calculateList.count {
    var curNum: Double = 0
    for j in 0..<calculateList[i].count {
        for item in alphabetsPriority {

            if item.0 == String(calculateList[i][calculateList[i].index(calculateList[i].startIndex, offsetBy: j)]) {
                curNum = (Double(item.1) * pow(10, Double(calculateList[i].count - 1 - j))) + curNum
            }
        }
    }
    ansSheet.append(Int(curNum))
}
print(ansSheet.reduce(0, +))
