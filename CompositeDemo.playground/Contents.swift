// モデルがツリー構造で表現できる場合のみ適用する意味がある
// 2種類のオブジェクト
// Product と Box があり、 いろんなものが Box の中に入っている状態

import UIKit

// 単純な要素でも複雑な要素でも同じインターフェースを持つ
protocol Examinee {
    /// 受験者名
    var name: String { get }
    /// スコア
    var score: Int { get }
    /// レポートする
    func report() -> String
}

/// 学生
struct Student: Examinee {
    let name: String
    let score: Int

    func report() -> String {
        return "\(name)の点数は\(score)です。"
    }
}

/// 受験者の集合体
struct Unit: Examinee {
    let name: String
    let subunits: [Examinee]
    var score: Int {
        return subunits.map { $0.score }.reduce(0, +)
    }
    func report() -> String {
        return "\(name)の点数は\(score)です。"
    }
}

// 使い方
let student1 = Student(name: "太郎", score: 50)
let student2 = Student(name: "花子", score: 70)
let student3 = Student(name: "吉野", score: 60)

student1.report()
student2.report()
student3.report()

let school1 = Unit(name: "東京学校", subunits: [student1, student2])
let school2 = Unit(name: "大阪学校", subunits: [student3])

school1.report()
school2.report()

////////////////////////////////////////////
// 複数の箇所にデータを送る

protocol AnalyticsEngine {
    func record(event: AnalyticsEvent)
}

/// 送信するデータ
protocol AnalyticsEvent {
    var name: String { get }
}

/// イベントのクラス（単純な要素）
struct DefaultEvent: AnalyticsEvent {
    let name: String
}

struct OSLogAnalyticsEngine: AnalyticsEngine {
    func record(event: AnalyticsEvent) {
        print("\(event.name) to OSLog")
    }
}

struct FirebaseaAnalyticEngine: AnalyticsEngine {
    func record(event: AnalyticsEvent) {
        print("\(event.name) to Firebase")
    }
}

struct CrashlyticsAnalyticEngine: AnalyticsEngine {
    func record(event: AnalyticsEvent) {
        print("\(event.name) to Crashlytics")
    }
}

// イベントのクラス（複雑な要素）
final class CompositeEngine: AnalyticsEngine {
    private let engines: [AnalyticsEngine]

    init(engines: AnalyticsEngine...) {
        self.engines = engines
    }

    func record(event: AnalyticsEvent) {
        engines.forEach {
            $0.record(event: event)
        }
    }
}

// 使い方

let firebase = FirebaseaAnalyticEngine()
let crashlytics = CrashlyticsAnalyticEngine()
let osLog = OSLogAnalyticsEngine()

let event1 = DefaultEvent(name: "サンプルイベント1")

firebase.record(event: event1) 

let composite1 = CompositeEngine(engines: firebase, crashlytics, osLog)
let event2 = DefaultEvent(name: "サンプルイベント2")
composite1.record(event: event2)
