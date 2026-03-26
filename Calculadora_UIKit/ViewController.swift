import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultadoLabel: UILabel!
    
    var num1: Double = 0
    var num2: Double = 0
    var operacion: String = ""
    var estaEscribiendo = false
    var historial: String = ""

    @IBAction func botonPresionado(_ sender: UIButton) {
        if let texto = sender.titleLabel?.text {
            print("Botón:", texto)
            if Double(texto) != nil || texto == "." {
                manejarNumero(texto)
            } else {
                manejarOperacion(texto)
            }
        }
    }

func manejarNumero(_ texto: String) {
    
    if texto == "." {
        if let textoCompleto = resultadoLabel.text {
            let partes = textoCompleto.components(separatedBy: " ")
            if let ultimo = partes.last, ultimo.contains(".") {
                return
            }
        }
    }
    
    if estaEscribiendo {
        if let actual = resultadoLabel.text {
            resultadoLabel.text = actual + texto
        }
    } else {
        resultadoLabel.text = texto
        estaEscribiendo = true
    }

    if operacion != "" {
        if let textoLabel = resultadoLabel.text {
            resultadoLabel.text = historial + " " + textoLabel
        }
    }
}

func manejarOperacion(_ texto: String) {

    if texto == "+" || texto == "-" || texto == "x" || texto == "/" {
        
        if operacion == "" {
            if let textoLabel = resultadoLabel.text, let valor = Double(textoLabel) {
                num1 = valor
                historial = "\(num1)"
            } else {
                resultadoLabel.text = "Error"
                return
            }
        } else if estaEscribiendo {
            
            if let textoLabel = resultadoLabel.text, let valor = Double(textoLabel) {
                num2 = valor
            } else {
                resultadoLabel.text = "Error"
                return
            }

            switch operacion {
            case "+":
                num1 += num2
            case "-":
                num1 -= num2
            case "x":
                num1 *= num2
            case "/":
                if num2 != 0 {
                    num1 /= num2
                } else {
                    resultadoLabel.text = "Error"
                    return
                }
            default:
                break
            }
            historial += " \(operacion) \(num2)"
        }

        operacion = texto
        historial += " \(texto)"
        resultadoLabel.text = historial
        estaEscribiendo = false
        return
    }

    if texto == "=" {

        if estaEscribiendo {
            if let textoCompleto = resultadoLabel.text {
                let partes = textoCompleto.components(separatedBy: " ")
                if let ultimo = partes.last, let valor = Double(ultimo) {
                    num2 = valor
                } else {
                    resultadoLabel.text = "Error"
                    return
                }
            } else {
                resultadoLabel.text = "Error"
                return
            }
        } else {
            num2 = num1
        }

        var resultadoFinal: Double = 0

        switch operacion {
        case "+":
            resultadoFinal = num1 + num2
        case "-":
            resultadoFinal = num1 - num2
        case "x":
            resultadoFinal = num1 * num2
        case "/":
            if num2 == 0 {
                resultadoLabel.text = "Error"
                return
            } else {
                resultadoFinal = num1 / num2
            }
        default:
            break
        }

        resultadoLabel.text = "\(resultadoFinal)"

        estaEscribiendo = false
        num1 = resultadoFinal
        operacion = ""
        historial = ""
    }

    if texto == "C" {
        resultadoLabel.text = "0"
        num1 = 0
        num2 = 0
        operacion = ""
        estaEscribiendo = false
        historial = ""
    }
}

override func viewDidLoad() {
        super.viewDidLoad()
        resultadoLabel.text = "0"
    }
}