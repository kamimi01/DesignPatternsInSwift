class Director {
    var builder: Builder

    init(builder: Builder) {
        self.builder = builder
    }

    func construct() {
        builder.buildName(name: "名前")
        builder.buildDescription(description: "詳細")
    }
}

protocol Builder {
    func result() -> Product
    func buildName(name: String)
    func buildDescription(description: String)
}

class MyBuilder1: Builder {
    private let product = Product()

    func buildName(name: String) {
        product.name = "\(name) by builder1"
    }

    func buildDescription(description: String) {
        product.description = "\(description) by builder1"
    }

    func result() -> Product {
        product
    }
}

class MyBuilder2: Builder {
    private let product = Product()

    func buildName(name: String) {
        product.name = "\(name) by builder2"
    }

    func buildDescription(description: String) {
        product.description = "\(description) by builder2"
    }

    func result() -> Product {
        product
    }
}

class Product {
    var name: String!
    var description: String!
}

// クライアント
let director1 = Director(builder: MyBuilder1())
let director2 = Director(builder: MyBuilder2())
director1.construct()
director2.construct()

print(director1.builder.result().name)
print(director2.builder.result().name)
