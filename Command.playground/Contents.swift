// command パターン

// コマンドクラス自身は処理をせず、誰が処理をするかを決めてお願いするだけ
// 一つの共通のメソッドを持つ
protocol Command {
    var receiver: Receiver { get }
    init(receiver: Receiver)
    func execute()
}

// 具象コマンドクラス
class Cut: Command {
    var receiver: Receiver

    required init(receiver: Receiver) {
        self.receiver = receiver
    }

    func execute() {
        receiver.action(toDo: "切る！")
    }
}

class Simmer: Command {
    var receiver: Receiver

    required init(receiver: Receiver) {
        self.receiver = receiver
    }

    func execute() {
        receiver.action(toDo: "煮る！")
    }
}

class StirFly: Command {
    var receiver: Receiver

    required init(receiver: Receiver) {
        self.receiver = receiver
    }

    func execute() {
        receiver.action(toDo: "炒める！")
    }
}

// 実際に処理をするのはReceiver
protocol Receiver {
    func action(toDo: String)
}

class Cooking: Receiver {
    func action(toDo: String) {
        print(toDo)
    }
}

// リクエストの開始を担当する。実際にコマンドを生成するのはクライアント
class Invoker {
    var commands = [Command]()

    func addCommand(command: Command) {
        self.commands.append(command)
    }

    func cookingStart() {
        for command in commands {
            command.execute()
        }
    }
}

// クライアント
let cook = Invoker()
let cooking = Cooking()

// 具象コマンドオブジェクトの作成と構成
let cut = Cut(receiver: cooking)
let simmer = Simmer(receiver: cooking)
let stirFly = StirFly(receiver: cooking)

// Invokerにリクエストの開始を依頼
cook.addCommand(command: cut)
cook.addCommand(command: simmer)
cook.addCommand(command: stirFly)

cook.cookingStart()

// メリット
// 単一責任の原則：処理を起動するクラスを、実際に処理をするクラスから分離できる
// 開放閉鎖の原則：新規コマンドをアプリに導入しても既存クライアントコードは問題なく動く
// 取り消しと再実行が出来る
// 操作の遅延実行
// 単純なコマンドを束ねて複雑なコマンドの作成が可能
