/// Input
let inputArr = readLine()!.split(separator: " ").map{ Int($0)! }
let N = inputArr[0]; let K = inputArr[1]
let devices = readLine()!.split(separator: " ").map{ Int($0)! }

var multitap: [(Int, Int)] = []
var ansNum = 0
for i in 0..<devices.count {
    let currentDevice = devices[i]
    if multitap.filter({ item in
        return item.0 != currentDevice
    }).count == multitap.count {
        /// 현재 꽃으려고 하는 장비가 없는 경우, 가장 빨리 뽑을 가능성 없는 친구를 뽑는다
        multitap.sort(by: { $0.1 < $1.1 })
        if multitap.count >= N {
            /// Multitap이 가득 차있을 경우
            ansNum += 1
            multitap.removeLast()
        }
        
        /// currentDevice 를 Multitap에 추가하는 작업
        for j in i+1..<K {
            if devices[j] == currentDevice {
                
                multitap.append((currentDevice, j ))
                break
            }
            if j == K - 1 {
                multitap.append((currentDevice, devices.count))
            }
        }
    } else {
        /// 현재 꽃으려고 하는 장비가 있는 경우
        for j in 0..<multitap.count{
            if multitap[j].0 == currentDevice {
                for k in i+1..<K {
                    if devices[k] == currentDevice {
                        multitap[j].1 = k
                        break
                    }
                    if k == K - 1 {
                        multitap[j].1 = devices.count
                    }
                }
            }
        }
    }
}
print(ansNum)
