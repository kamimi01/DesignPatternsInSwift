protocol Programmer {
    func programming()
    func excelWork()
    func deepQuestion()
}

// サービスクラス
class ProgrammerService: Programmer {
    func programming() {
        print("元請：プログラミングする")
    }

    func excelWork() {
        print("元請：excel資料を作る")
    }

    func deepQuestion() {
        print("元請：それはxxですよ")
    }
}

// プロキシークラス
class ProgrammerProxy: Programmer {
    private var service: Programmer = ProgrammerService()

    // プロキシークラスを挟むことで、処理を挟み込める
    func programming() {
        print("下請け：プログラミングする")
    }

    // プロキシークラスを挟むことで、処理を挟み込める
    func excelWork() {
        print("下請け：excel資料を作る")
    }

    func deepQuestion() {
        service.deepQuestion()
    }
}

// クライアント
let proxy = ProgrammerProxy()
proxy.programming()
proxy.excelWork()
proxy.deepQuestion()
