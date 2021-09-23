import UIKit
import NaturalLanguage

// CustomStringConvertibleを使うことで、この構造体をインスタンス化してprintするときに出力される文字列が値自身になる
// https://developer.apple.com/documentation/swift/customstringconvertible
struct WordLexicalClassPair: CustomStringConvertible {
    let word: String
    let lexicalClass: String
    
    var description: String {
        return "\"\(word)\": \(lexicalClass)"
    }
}

class NLPFacade {
    
    /// タグのタイプを判別する
    private static let tagger = NLTagger(tagSchemes: [.lexicalClass])
    
    /// 入力された文字列を分析して、言語名を返却する。認識できなかった場合は、nilを返却する。
    /// - Parameter string: 分析対象の文字列
    /// - Returns: 言語名（optionalのNLLanguage）
    class func dominantLanguage(for string: String) -> String? {
        let language = NLLanguageRecognizer.dominantLanguage(for: string)
        
        return language?.rawValue
    }
    
    /// 入力された文字列を分析して、ワードの組み合わせのタイプを返す
    /// - Parameter text: 分析対象の文字列
    /// - Returns: ワードの組み合わせのタイプ
    class func partsOfSpeech(for text: String) -> [WordLexicalClassPair] {
        var result = [WordLexicalClassPair]()
        
        tagger.string = text
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: NLTokenUnit.word, scheme: NLTagScheme.lexicalClass, options: [.omitPunctuation, .omitWhitespace]) { (tag, range) -> Bool in
            let wordLexicalClass = WordLexicalClassPair(word: String(text[range]), lexicalClass: (tag?.rawValue ?? "unknown"))

            result.append(wordLexicalClass)
            return true
        }
        
        return result
    }
}


// ---------------------------

let text = "The Façade is simple yet useful"
print(text)

let language = NLPFacade.dominantLanguage(for: text) ?? "unknown"
print(language)

let result = NLPFacade.partsOfSpeech(for: text)
print(result)
