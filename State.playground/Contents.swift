// 状態：walking / running
// 状態の所有者：User
protocol State {
    func move(user: User)
    func speed(user: User) -> Int
}

class Walking: State {
    var moveCount = 0

    func move(user: User) {
        moveCount += 1
        if 2 <= moveCount {
            user.state = Running()
        }
    }

    func speed(user: User) -> Int {
        return 3
    }
}

class Running: State {
    var moveCount = 0

    func move(user: User) {
        moveCount += 1
        if 3 <= moveCount {
            user.state = Walking()
        }
    }

    func speed(user: User) -> Int {
        return 10
    }
}

// 使用するのはこのクラスだけ
class User {
    var state: State = Running()

    func move() {
        state.move(user: self)
    }

    func speed() -> Int {
        return state.speed(user: self)
    }
}

let user = User()
print(user.speed())  // Running の状態

user.move()
user.move()
user.move()

print(user.speed())  // Walking の状態
