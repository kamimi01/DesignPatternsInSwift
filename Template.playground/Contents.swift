protocol Emotion {
    var face: String { get }
    init(face: String)
    func makeLeftSide() -> String
    func makeRightSide() -> String
    func printEmotion()
}

extension Emotion {
    // デフォルト実装（= テンプレート）
    func printEmotion() {
        let emotion = makeLeftSide() + face + makeRightSide()
        print(emotion)
    }
}

final class Normal: Emotion {
    let face: String

    required init(face: String) {
        self.face = face
    }

    func makeLeftSide() -> String {
        return "("
    }

    func makeRightSide() -> String {
        return ")"
    }
}

class Crab: Emotion {
    let face: String

    required init(face: String) {
        self.face = face
    }

    func makeLeftSide() -> String {
        return "v("
    }

    func makeRightSide() -> String {
        return ")v"
    }
}

// 呼び出し
let normal = Normal(face: "`･ω･´")
normal.printEmotion()  // (`･ω･´)
let crab = Crab(face: "`･ω･´")
crab.printEmotion()  // v(`･ω･´)v
