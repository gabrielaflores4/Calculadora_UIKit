import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resultadoLabel: UILabel!
    
    var num1: Double = 0
    var num2: Double = 0
    var operacion: String = ""
    var estaEscribiendo = false

    @IBAction func botonPresionado(_ sender: UIButton) {
       let texto = sender.currentTitle!
       if Double(texto) != nil || texto == "." {
           manejarNumero(texto)
       } else {
           manejarOperacion(texto)
       }
    }

    func manejarNumero(_ texto: String) {
        if estaEscribiendo {
            resultadoLabel.text = resultadoLabel.text! + texto
        } else {
            resultadoLabel.text = texto
            estaEscribiendo = true
        }
    }

    func manejarOperacion(_ texto: String) {

        if texto == "+" || texto == "-" || texto == "x" || texto == "/" {
            num1 = Double(resultadoLabel.text!) ?? 0
            operacion = texto
            estaEscribiendo = false
            return
        }

        if texto == "=" {
            num2 = Double(resultadoLabel.text!) ?? 0

            switch operacion {
            case "+":
                resultadoLabel.text = "\(num1 + num2)"
            case "-":
                resultadoLabel.text = "\(num1 - num2)"
            case "x":
                resultadoLabel.text = "\(num1 * num2)"
            case "/":
                if num2 == 0 {
                    resultadoLabel.text = "Error"
                } else {
                    resultadoLabel.text = "\(num1 / num2)"
                }
            default:
                break
            }

            estaEscribiendo = false
        }

        if texto == "C" {
            resultadoLabel.text = "0"
            num1 = 0
            num2 = 0
            operacion = ""
            estaEscribiendo = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultadoLabel.text = "0"
        view.backgroundColor = .red
        print("Si cargo")
    }
}
