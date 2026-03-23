import UIKit

class ViewController: UIViewController {

    var displayLabel = UILabel()
    var currentNumber: Double = 0
    var previousNumber: Double = 0
    var operation: String = ""
    var isTyping = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        displayLabel.frame = CGRect(x: 20, y: 80, width: 300, height: 80)
        displayLabel.text = "0"
        displayLabel.textColor = .white
        displayLabel.font = UIFont.systemFont(ofSize: 40)
        displayLabel.textAlignment = .right
        view.addSubview(displayLabel)

        let titles = ["1","2","3","+","4","5","6","="]

        let buttonWidth: CGFloat = 70
        let buttonHeight: CGFloat = 70
        var x: CGFloat = 20
        var y: CGFloat = 180

        for (index, title) in titles.enumerated() {

            let button = UIButton(type: .system)
            button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)

            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            view.addSubview(button)

            x += buttonWidth + 10

            if (index + 1) % 4 == 0 {
                x = 20
                y += buttonHeight + 10
            }
        }
    }

    @objc func buttonTapped(_ sender: UIButton) {
        guard let text = sender.currentTitle else { return }

        if Double(text) != nil {
            if isTyping {
                displayLabel.text = displayLabel.text! + text
            } else {
                displayLabel.text = text
                isTyping = true
            }
        } else {
            if text == "+" {
                previousNumber = Double(displayLabel.text!) ?? 0
                operation = "+"
                isTyping = false
            }

            if text == "=" {
                currentNumber = Double(displayLabel.text!) ?? 0

                if operation == "+" {
                    displayLabel.text = "\(previousNumber + currentNumber)"
                }
            }
        }
    }
}