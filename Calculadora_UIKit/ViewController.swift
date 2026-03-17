import UIKit

class ViewController: UIViewController {

    private var displayLabel = UILabel()
    private var currentNumber: Double = 0
    private var previousNumber: Double = 0
    private var operation: String = ""
    private var isTyping = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupDisplay()
        setupButtons()
        // Do any additional setup after loading the view.
    }

    private func setupDisplay() {
        displayLabel.text = "0"
        displayLabel.textColor = .white
        displayLabel.font = UIFont.systemFont(ofSize: 40)
        displayLabel.textAlignment = .right
        displayLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(displayLabel)

        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }   

    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        return button
    }

    private func setupButtons() {
        let rows = [
            ["1", "2", "3", "+"],
            ["4", "5", "6", "-"],
            ["7", "8", "9", "*"],
            ["0", "=", "C", "/"]
        ]

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        for row in rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.distribution = .fillEqually

            for title in row {
                let button = createButton(title: title)
                rowStack.addArrangedSubview(button)
            }

            mainStack.addArrangedSubview(rowStack)
        }

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func buttonTapped(_ sender: UIButton) {
    guard let text = sender.currentTitle else { return }

    if let number = Double(text) {
        if isTyping {
            displayLabel.text = displayLabel.text! + text
        } else {
            displayLabel.text = text
            isTyping = true
        }
    } else {
        switch text {
            case "+":
                previousNumber = Double(displayLabel.text!) ?? 0
                operation = "+"
                isTyping = false

            case "=":
                currentNumber = Double(displayLabel.text!) ?? 0

                if operation == "+" {
                    displayLabel.text = "\(previousNumber + currentNumber)"
                }

            default:
                break
            }
        }
    }

    

}

