// Swift では元々IteratorProtocolに準拠しているので、そのままそれに準拠したプリミティブ型を使用すればいい
let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]

for animal in animals {
    print(animal)
}

// 自分で自作して使いたい場合もある
// 一部のアルゴリズムでは使うこともある↓（よくわからん、reduceがわかっていない）

extension Sequence {
    func reduce1(
        _ nextPartialResult: (Element, Element) -> Element
    ) -> Element? {
        var i = makeIterator()
        guard var accumulated = i.next() else {
            return nil
        }

        while let element = i.next() {
            accumulated = nextPartialResult(accumulated, element)
        }
        return accumulated
    }
}

// 別のパターン
class RandomList: IteratorProtocol {
    typealias Element = String

    var index = 0
    var data = ["データ1", "データ2", "データ3", "データ4"]

    func hasNext() -> Bool {
        return 1 <= data.count
    }

    func next() -> Element? {
        // 特定の index（今回は常に 1）を次の要素として返却したいとき
        let index = 1
        let datum = data[safe: index]
        if datum == nil {
            return nil
        }
        // 配列から削除する
        data.remove(at: index)
        return datum
    }
}

extension Array {
    // indexがないあらnilを返す
    subscript (safe index: Index) -> Element? {
        //indexが配列内なら要素を返し、配列外ならnilを返す（三項演算子）
        return indices.contains(index) ? self[index] : nil
    }
}

// クライアントからの使用方法
let list = RandomList()
print(list)
print("テスト")

// nilになったらfalseになるのでループをやめる
var result = true
while list.hasNext() && result {
    let next = list.next()
    if next == nil {
        result = false
    }
    print(next)
}
