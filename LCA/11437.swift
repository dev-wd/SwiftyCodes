import Foundation
/// Define DFS for finding depth
func DFS(node: Int) -> Void {
    var stack: [Int] = []
    stack.append(node)
    while !stack.isEmpty {
        let currentNode = stack.popLast()!
        guard isChecked[currentNode] == false else { continue }
        isChecked[currentNode] = true
        depth[currentNode] = depth[parent[currentNode]] + 1
        for childNode in tree[currentNode] {
            if parent[currentNode] != childNode {
                parent[childNode] = currentNode
                stack.append(childNode)
            }
        }
    }
}

/// Define LCA
func LCA(target1: Int, target2: Int) -> Void {
    var target1 = target1; var target2 = target2
    /// Match depth between two targets
    while depth[target1] != depth[target2] {
        if depth[target1] > depth[target2] {
            target1 = parent[target1]
        } else {
            target2 = parent[target2]
        }
    }
    /// Ride a tree for finding same parent
    while parent[target1] != parent[target2] {
        target1 = parent[target1]
        target2 = parent[target2]
    }
    let ans = target1 == target2 ? target1 : parent[target1]
    print(ans)
}



/// Get the number of Nodes
let N = readLine().map{ Int($0)! }!
var edges: [(Int, Int)] = []
var inputs: [(Int, Int)] = []
for _ in 0..<N-1 {
    let arr = readLine()!.split(separator: " ").map{ Int($0)! }
    let edge: (Int, Int) = (arr.first!, arr.last!)
    edges.append(edge)
}

/// Get input for finding common ancestor
let M = readLine().map{ Int($0)! }!
for _ in 0..<M  {
    let arr = readLine()!.split(separator: " ").map{ Int($0)! }
    let inputLine: (Int, Int) = (arr.first!, arr.last!)
    inputs.append(inputLine)
}

/// Make a tree by input nodes
var tree: [[Int]]       = Array.init(repeating: Array.init(repeating: 0, count: 0), count: N+1)
var parent: [Int]       = Array.init(repeating: 0, count: N+1)
var depth: [Int]        = Array.init(repeating: 0, count: N+1)
var isChecked: [Bool]   = Array.init(repeating: false, count: N+1)

for edge in edges {
    tree[edge.0].append(edge.1); tree[edge.1].append(edge.0)
}

DFS(node: 1)
inputs.forEach{ currentInput in
    LCA(target1: currentInput.0, target2: currentInput.1)
}

