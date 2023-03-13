import Foundation

class Author {
    private var id: Int
    private var username: String
    private var pages = [Page]()

    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }

    func add(page: Page) {
        pages.append(page)
    }

    var pagesCount: Int {
        return pages.count
    }
}

class Page: NSCopying {
    private(set) var title: String
    private(set) var contents: String
    private weak var author: Author?
    private(set) var comments = [Comment]()

    init(title: String, contents: String, author: Author?) {
        self.title = title
        self.contents = contents
        self.author = author
        author?.add(page: self)
    }

    func add(comment: Comment) {
        comments.append(comment)
    }

    // MARK: - NSCopying
    // FIXME: 戻り値の型を指定することができない
    func copy(with zone: NSZone? = nil) -> Any {
        return Page(title: "Copy of " + title, contents: contents, author: author)
    }
}

struct Comment {
    let date = Date()
    let message: String
}

// クライアント
let author = Author(id: 10, username: "松尾芭蕉")
let page = Page(title: "奥の細道", contents: "奥の細道の内容", author: author)

page.add(comment: Comment(message: "Keep it up"))

print(page.title)
print(page.contents)
print(page.comments.first?.message)

// NSCopying は 戻り値がAny なので、キャストする必要がある
if let anothorPage = page.copy() as? Page {
    print(anothorPage.title)
    print(anothorPage.contents)
    print(anothorPage.comments.first?.message)
}


