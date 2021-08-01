//
//  ConvertVC.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 01/08/2021.
//

import UIKit

class ConverterVC: BaseVC {
    var currency: Currency?
    @IBOutlet weak var mainCurrencyLabel:UILabel!
    @IBOutlet weak var secondCurrencyLabel:UILabel!
    @IBOutlet weak var mainCurrencyText:UITextField!
    @IBOutlet weak var secondCurrencyText:UITextField!
    var vm: CurrenciesListVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let curr = currency {
            var ccode = curr.name
            ccode.removeLast()
            secondCurrencyLabel.text = "\(ccode.flag()) \(curr.name)"
        }
        var mainCode = vm?.selectedCurrency.name ?? ""
        mainCode.removeLast()
        mainCurrencyLabel.text =  "\(mainCode.flag()) \(vm?.selectedCurrency.name ?? "")"//
        textChanged()
        mainCurrencyText.becomeFirstResponder()
    }
    @IBAction func textChanged(){
        let value = Double(mainCurrencyText.text!) ?? 0.0
        if let curr = currency, let result = vm?.convertCurrency(value: value, currency: curr) {
            secondCurrencyText.text = String(format: "%\(0.5)f", result)
        }
    }
}

