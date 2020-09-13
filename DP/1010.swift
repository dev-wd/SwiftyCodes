///  Data
let T = Int(readLine()!)!
var nmList: [[Int]] = []

/// Input Stream
for _ in 0..<T {
    let nm = readLine()!
        .split(separator: " ")
        .map{ Int($0)! }
    nmList.append(nm)
}

for t in 0..<nmList.count {
    /// Define NMmatrix
    /// N : west M: east
    let N = nmList[t][0]
    let M = nmList[t][1]
    var d = Array(repeating: Array(repeating: 0, count: M+1),
                  count: N+1)
    
    /// d[n][m] = d[n-1][0] + .. + d[n-1][m-1]
    for i in 1...M { d[1][i] = i }
    guard N != 1 else { print(d[N][M]); continue }
    for i in 2...N {
        for j in i...M {
            for k in (i...j).reversed() {
                d[i][j] += d[i-1][k-1]
            }
        }
    }
    print(d[N][M])
}
