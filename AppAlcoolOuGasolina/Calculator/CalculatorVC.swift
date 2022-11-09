//
//  CalculatorVC.swift
//  AppAlcoolOuGasolina
//
//  Created by user218997 on 09/11/22.
//

import UIKit

class CalculatorVC: UIViewController {
    
    var screen: CalculatorScreen?
    var alert: Alert?
    
    override func loadView() {
        screen = CalculatorScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        screen?.delegate(delegate: self)
        alert = Alert(controller: self)
    }

    func validateTextFields() -> Bool {
        guard let ethanolPrice = screen?.ethanolPriceTextField.text else { return false }
        guard let gasPrice = screen?.gasPriceTextField.text else { return false }
        
        if ethanolPrice.isEmpty && gasPrice.isEmpty {
            alert?.showAlertInformation(title: "Atenção!", message: "Informe os valores do álcool e da gasolina")
            return false
        } else if ethanolPrice.isEmpty {
            alert?.showAlertInformation(title: "Atenção!", message: "Informe o valor do álcool")
            return false
        } else if gasPrice.isEmpty {
            alert?.showAlertInformation(title: "Atenção!", message: "Informe o valor da gasolina")
            return false
        }
        return true
    }
    
}

extension CalculatorVC: CalculatorScreenDelegate {
    func tappedCalculateButton() {
        
        if validateTextFields() {

            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal

            let ethanolPrice: Double = (formatter.number(from: screen?.ethanolPriceTextField.text ?? "0.0") as? Double) ?? 0.0
            let gasPrice: Double = (formatter.number(from: screen?.gasPriceTextField.text ?? "0.0") as? Double) ?? 0.0

            var vc: ResultVC?
            if ethanolPrice / gasPrice > 0.7 {
                print("Melhor utilizar Gasolina")
                vc = ResultVC(bestFuel: .gas)
            } else {
                print("Melhor utilizar Álcool")
                vc = ResultVC(bestFuel: .ethanol)
            }
            navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        }
    }
    
    func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}
