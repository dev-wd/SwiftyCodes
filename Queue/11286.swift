extension Array where Element == Int {
    mutating func binarySearch(val: Int) {
        var start = 0
        var end = self.count - 1
        var mid = (start + end) / 2
        guard val != 0 else {
            if self.isEmpty == true { print("0"); return }
            print(self.remove(at: end))
            return
        }
        
        if self.isEmpty == true { self.append(val); return }
        
        while(end - start >= 0) {
            mid = (end + start) / 2
            if abs(val) < abs(self[mid]) ||  (abs(val) == abs(self[mid]) && self[mid] > val){
                start = mid + 1
            }
            else {
                end = mid - 1
            }
        }
        
        self.insert(val, at: start)
    }
    
}

let N = Int(readLine()!)!
var inputList: [Int] = []

for _ in 0..<N {
    inputList.binarySearch(val: Int(readLine()!)!)
}

