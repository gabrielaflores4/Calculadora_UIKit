import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var resultadoLabel: UILabel!
    
    var num1: Double = 0
    var num2: Double = 0
    var operacion: String = ""
    var estaEscribiendo = false

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
        
        if texto == "." && resultadoLabel.text?.contains(".") == true {
            return
        }
        
        if estaEscribiendo {
            resultadoLabel.text = (resultadoLabel.text ?? "") + texto
        } else {
            resultadoLabel.text = texto
            estaEscribiendo = true
        }
    }

    func manejarOperacion(_ texto: String) {

        if texto == "+" || texto == "-" || texto == "x" || texto == "/" {
            
            if operacion == "" {
                num1 = Double(resultadoLabel.text!) ?? 0
            } else if estaEscribiendo {
                
                num2 = Double(resultadoLabel.text!) ?? 0

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
            }

            operacion = texto
            resultadoLabel.text = "\(num1)"
            estaEscribiendo = false
            return
        }

        if texto == "=" {

            if estaEscribiendo {
                num2 = Double(resultadoLabel.text!) ?? 0
            } else {
                num2 = num1
            }

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
                    return
                } else {
                    resultadoLabel.text = "\(num1 / num2)"
                }
            default:
                break
            }

            estaEscribiendo = false
            num1 = Double(resultadoLabel.text!) ?? 0
            operacion = ""
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
    }
}

//Preview
struct UIKitContentView_Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let bundle = Bundle(for: ViewController.self)
        print("Bundle: \(bundle)")
        
        // Verificar que el storyboard existe en el bundle
        guard let storyboardURL = bundle.url(forResource: "Main", withExtension: "storyboardc") else {
            fatalError("No se encontró Main.storyboardc en el bundle \(bundle)")
        }
        print("Storyboard encontrado en: \(storyboardURL)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        // Intentar instanciar el controlador por su identifier
        let identifier = "ViewController"
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        print("Controlador instanciado: \(vc)")
        
        guard let viewController = vc as? ViewController else {
            fatalError("El controlador con identifier '\(identifier)' no es de tipo ViewController. Es de tipo: \(type(of: vc))")
        }
        
        viewController.loadViewIfNeeded()
        return UINavigationController(rootViewController: viewController)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}

#Preview {
    UIKitContentView_Preview()
}
