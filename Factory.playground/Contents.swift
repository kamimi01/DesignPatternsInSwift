// Product クラス
protocol Button {
    func render()
    func onClick()
}

class WindowsButton: Button {
    func render() {
        print("windowsを描画する")
    }

    func onClick() {
        print("windowsのポップアップを表示する")
    }
}

class HTMLButton: Button {
    func render() {
        print("HTMLButton を描画する")
    }

    func onClick() {
        print("HTMLButton のポップアップを表示する")
    }
}

// creator クラス
protocol Dialog {
    func render()
    func createButton() -> Button
}

extension Dialog {
    // デフォルト実装
    func render() {
        let okButton = createButton()
        okButton.onClick()
        okButton.render()
    }

    func createButton() -> Button {
        return WindowsButton()
    }
}

class WindowsDialog: Dialog {
    func createButton() -> Button {
        return WindowsButton()
    }
}

class WebDialog: Dialog {
    func createButton() -> Button {
        return HTMLButton()
    }
}

// クライアント
let dialog = WindowsDialog()
dialog.render()

let dialog2 = WebDialog()
dialog2.render()
