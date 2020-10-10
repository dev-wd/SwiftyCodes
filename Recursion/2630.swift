import Foundation

let n = readLine().map { Int($0)! }!
var matrix: [[Int]] = []
for _ in 0..<n {
    matrix.append(readLine()!.split(separator: " ").map{ Int($0)! })
}

var whiteAns = 0
var blueAns = 0

func rec(rowS: Int, rowE: Int, colS: Int, colE: Int) -> () {

    let sameNum = matrix[colS][rowS]
    for i in colS...colE {
        for j in rowS...rowE {
            
            if matrix[i][j] != sameNum {
                rec(rowS: rowS,
                    rowE: rowS + (rowE - rowS)/2,
                    colS: colS,
                    colE: colS + (colE - colS)/2)
                
                rec(rowS: rowS + (rowE - rowS + 1)/2,
                    rowE: rowE,
                    colS: colS,
                    colE: colS + (colE - colS)/2)
                
                rec(rowS: rowS,
                    rowE: rowS + (rowE - rowS)/2,
                    colS: colS + (colE - colS + 1)/2,
                    colE: colE)
                
                rec(rowS: rowS + (rowE - rowS + 1)/2,
                    rowE: rowE,
                    colS: colS + (colE - colS + 1)/2,
                    colE: colE)
                return
            }
        }
    }
    if sameNum == 0 {
        
        whiteAns += 1
    } else {
        blueAns += 1
    }
}

rec(rowS: 0, rowE: matrix.count - 1, colS: 0, colE: matrix.count - 1)
print(whiteAns)
print(blueAns)
