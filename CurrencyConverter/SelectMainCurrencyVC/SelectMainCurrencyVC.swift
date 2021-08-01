//
//  SelectMainCurrencyVC.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SelectMainCurrencyVC: UIViewController {
    @IBOutlet weak var currenciesTableView:UITableView!
    private let reuseId = "CurrencyCell"
    var currencies:[Currency] = []
    let selectedCurency: BehaviorRelay<Currency?> = BehaviorRelay<Currency?>(value: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        currenciesTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        currenciesTableView.rowHeight = UITableView.automaticDimension
    }
}


extension SelectMainCurrencyVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurency.accept(currencies[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SelectMainCurrencyVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! CurrencyCell
        let currency = currencies[indexPath.row]
        if currency.name.count > 0{
            var ccode = currency.name
            ccode.removeLast()
            cell.currencyNameLabel.text = ccode.flag() + "  " + currency.name
            cell.currencyValueLabel.text = "\(currency.ratio)"
        }
        return cell
    }
    
}

