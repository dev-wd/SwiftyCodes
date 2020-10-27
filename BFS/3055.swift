import Foundation

public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0

  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }

  public mutating func dequeue() -> T? {
    guard let element = array[guarded: head] else { return nil }

    array[head] = nil
    head += 1

    let percentage = Double(head)/Double(array.count)
    if array.count > 50 && percentage > 0.25 {
      array.removeFirst(head)
      head = 0
    }

    return element
  }

  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}

/// Input
let nmList = readLine()!.split(separator: " ").map{ Int($0)! }
var matrix: [[Character]] = []

for _ in 0 ..< nmList[0] {
    var tem: [Character] = []
    readLine()!.forEach { tem.append($0) }
    matrix.append(tem)
}

/// Type
enum BFSType {
    case water
    case hedgehog
}


/// BFS
/// 고슴도치: S / 바비의 굴: D / 물이 차있는 곳: *
let dx = [1, 0, -1, 0]
let dy = [0, 1, 0, -1]

var waterQueue: Queue<(Int, Int)> = Queue<(Int, Int)>()
var hedgehogQueue: Queue<(Int, Int)> = Queue<(Int, Int)>()

func bfs(wList: [(Int, Int)], hRow: Int, hCol: Int) {
    
    
    wList.forEach {
        waterQueue.enqueue(($0.1, $0.0))
    }
    hedgehogQueue.enqueue((hRow, hCol))
    var ans = 0
    
    while(true) {
        ans += 1
        if hedgehogQueue.count == 0 {
            print("KAKTUS")
            return
        }
        
        expandWater()
        if expandHedgehog() {
            print(ans)
            return
        }
    }
}

var h: (Int, Int)?
var wList: [(Int, Int)] = []

for i in 0..<nmList[0] {
    for j in 0..<nmList[1] {
        if matrix[i][j] == "*" { wList.append((i, j)) }
        if matrix[i][j] == "S" { h = (i, j)}
    }
}

func expandWater() {
    let size = waterQueue.count
    for _ in 0..<size {
        let temWater = waterQueue.dequeue()
        
        for j in 0..<4 {
            let tx = dx[j] + temWater!.0
            let ty = dy[j] + temWater!.1
            if  tx >= 0 && tx <= nmList[1] - 1 && ty >= 0 && ty <= nmList[0] - 1 {
                if matrix[ty][tx] == "." {
                    matrix[ty][tx] = "*"
                    waterQueue.enqueue((tx, ty))
                }
            }
        }
    }
}

func expandHedgehog() -> Bool {
    let size =  hedgehogQueue.count
    for _ in 0..<size {
        let temHedgehog = hedgehogQueue.dequeue()
        
        for j in 0..<4 {
            let tx = dx[j] + temHedgehog!.0
            let ty = dy[j] + temHedgehog!.1
            if  tx >= 0 && tx <= nmList[1] - 1 && ty >= 0 && ty <= nmList[0] - 1  {
                if matrix[ty][tx] == "D" {
                    hedgehogQueue.enqueue((tx, ty))
                    return true
                }
                if matrix[ty][tx] == "." {
                    matrix[ty][tx] = "S"
                    hedgehogQueue.enqueue((tx,ty))
                }
            }
        }
    }
    return false
}

bfs(wList: wList, hRow: h!.1, hCol: h!.0)
