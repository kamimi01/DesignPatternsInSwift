class LendingList {
    func canLend(name: String) -> Bool {
        // 仮で固定trueにしている
        return true 
    }
}

class BookList {
    func searchBookLocation(name: String) -> String? {
        // 仮で固定trueにしている
        return "E10"
    }
}

class Librarian {
    func searchBook(name: String) -> String {
        let bookList = BookList()

        if let location = bookList.searchBookLocation(name: name) {
            let lendingList = LendingList()
            if lendingList.canLend(name: name) {
                return location
            }
            return "貸出中"
        }
        return "その本は所蔵していませんん"
    }
}

// クライアント
let librarian = Librarian()
librarian.searchBook(name: "デザインパターン入門")
