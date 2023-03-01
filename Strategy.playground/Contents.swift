enum Animal {
    case dog
    case cat
    case lion
}

protocol Strategy {
    func execute()
}

func strategy(for type: Animal) -> Strategy {
    switch type {
    case .dog: return DogStrategy()
    case .cat: return CatStrategy()
    case .lion: return LionStrategy()
    }
}

class DogStrategy: Strategy {
    func execute() {
        print("わん！")
    }
}

class CatStrategy: Strategy {
    func execute() {
        print("ニャア")
    }
}

class LionStrategy: Strategy {
    func execute() {
        print("ガオー")
    }
}

func execute(type: Animal) {
    strategy(for: type).execute()
}

execute(type: .dog)
execute(type: .cat)
execute(type: .lion)
