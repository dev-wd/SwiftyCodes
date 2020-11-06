import Foundation

let N = readLine().map { Int($0)! }!
var d = Array.init(repeating:
                    Array.init(repeating: -1, count: 3), count: N)

/// Get RGB inputs
var rgb: [[Int]] = []
for _ in 0..<N {
    let tem = readLine()!.split(separator: " ").map { Int($0)! }
    rgb.append(tem)
}


for i in 0..<N {
    if i == 0 {
        /// Set initial value
        for j in 0..<3 {
            d[i][j] = rgb[i][j]
        }
    } else {
        for j in 0..<3 {
            if j == 0 {
                d[i][j] =  rgb[i][j] + min(d[i-1][1], d[i-1][2])
            } else if j == 1 {
                d[i][j] =  rgb[i][j] + min(d[i-1][0], d[i-1][2])
            } else {
                d[i][j] =  rgb[i][j] + min(d[i-1][0], d[i-1][1])
            }
        }
    }
}

print(min(d.last![0], d.last![1], d.last![2]))
