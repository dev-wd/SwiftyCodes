import Foundation

/// Input
let city_num = readLine().map{ Int($0)! }!
let road_num = readLine().map{ Int($0)! }!

var city_path: [[Int]] = Array(repeating: Array(repeating: 20000000, count: city_num), count: city_num)
for _ in 0..<road_num {
    let tem = readLine()!.split(separator: " ").map{ Int($0)! }
    if city_path[tem[0]-1][tem[1]-1] > tem[2] {
        city_path[tem[0]-1][tem[1]-1] = tem[2]
    }
}

/// d[i][j] vs d[i][k] +  d[k][j]
for k in 0..<city_num {
    for i in 0..<city_num {
        for j in 0..<city_num {
            if i == j {
                city_path[i][j] = 0
                continue
            }
            city_path[i][j] = min(city_path[i][j], city_path[i][k] + city_path[k][j])
        }
    }
}

/// Output
for i in 0..<city_num {
    var line = ""
    for j in 0..<city_num {
        if city_path[i][j] >= 20000000 {
            city_path[i][j] = 0
        }
        if j == city_num - 1 {
            line += "\(city_path[i][j])"
        } else {
            line += "\(city_path[i][j]) "
        }
    }
    print(line)
}
