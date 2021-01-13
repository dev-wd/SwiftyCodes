import  Foundation

/// Functions
func combos<T>(elements: ArraySlice<T>, k: Int) -> [[T]] {
    if k == 0 {
        return [[]]
    }
    
    guard let first = elements.first else {
        return []
    }
    
    let head = [first]
    let subcombos = combos(elements: elements, k: k - 1)
    var ret = subcombos.map { head + $0 }
    ret += combos(elements: elements.dropFirst(), k: k)
    
    return ret
}

func combos<T>(elements: Array<T>, k: Int) -> [[T]] {
    return combos(elements: ArraySlice(elements), k: k)
}

func isDuplicated(element: [Int]) -> Bool {
    var set: Set<Int> = []
    element.forEach{ set.insert($0) }
    return set.count != 3
}


public struct Deque<T> {
    private var array = Array<T>()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
}

func BFSResult(matrix: [[Int]]) -> Int {
    var copiedMatrix = matrix
    var startingPoints: [(Int, Int)] = []
    var deque: Deque = Deque<(Int, Int)>()
    var safeAreaCount = 0
    
    for i in 0..<copiedMatrix.count {
        for j in 0..<copiedMatrix.first!.count {
            if copiedMatrix[i][j] == 2 {
                startingPoints.append((i,j))
            }
        }
    }
    
    startingPoints.forEach{ deque.enqueue($0) }
    
    /// Define directions
    let dx: [Int] = [1, 0, 0,-1]
    let dy: [Int] = [0,-1, 1, 0]
    
    while !deque.isEmpty {
        let current = deque.dequeue()!; let curX = current.0; let curY = current.1
        
        for i in 0..<4 {
            let nextX = curX + dx[i]; let nextY = curY + dy[i]
            if nextX < N && nextX >= 0 && nextY < M && nextY >= 0 && copiedMatrix[nextX][nextY] == 0 {
                copiedMatrix[nextX][nextY] = 2
                deque.enqueue((nextX, nextY))
            }
        }
    }
    
    copiedMatrix.forEach { row in
        safeAreaCount += row.filter{ $0 == 0 }.count
    }
    return safeAreaCount
}


/// Matrix
let getString = readLine()!.split(separator: " ").map { Int($0)! }
let N = getString[0], M = getString[1]

var matrix: [[Int]] = []
for _ in 0..<N {
    matrix.append(readLine()!.split(separator: " ").map { Int($0)! })
}

/// Get Zero positions
var zeroArea: [Int] = []
for i in 0..<N {
    for j in 0..<M {
        if matrix[i][j] == 0 {
            zeroArea.append(i*10 + j)
        }
    }
}

/// Sort all cases
var cases: [[Int]] = []
combos(elements: zeroArea, k: 3)
    .forEach {
        if !isDuplicated(element: $0) {
            cases.append($0)
        }
    }

var ans = 0
/// Iterate for each cases
cases.forEach { coordinates in
    var testMatrix = matrix
    /// make zero position to one for each cases
    coordinates.forEach { coordinate in
        let x = coordinate / 10; let y = coordinate % 10
        testMatrix[x][y] = 1
    }
    
    let currentResult = BFSResult(matrix: testMatrix)
    ans = ans > currentResult ? ans : currentResult
}

print(ans)
