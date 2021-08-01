//
//  CurrenciesListVC.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CurrenciesListVC: BaseVC {
    lazy var vm: CurrenciesListVM = CurrenciesListVM(disposeBag: self.disposeBag)
    @IBOutlet weak var currenciesTableView:UITableView!
    private let reuseId = "CurrencyCell"
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = UIColor.AppColors.BlueColor
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        currenciesTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        currenciesTableView.rowHeight = UITableView.automaticDimension
        vm.fetchCurenciesList()
        addTitleLabel()
    }
    func addTitleLabel(){
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 40),
            ])
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        currenciesTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        currenciesTableView.rowHeight = UITableView.automaticDimension
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.backgroundColor = .white
        navigationItem.titleView = label
        navigationController?.navigationBar.backgroundColor = .blue
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerHandler(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(touchGesture)
    }
    @objc func tapGestureRecognizerHandler(_ sender: UITapGestureRecognizer) {
        //change main currency
        if vm.currencies.count > 0{
            if let vc = storyboard?.instantiateViewController(identifier: "SelectMainCurrencyVC") as? SelectMainCurrencyVC{
                //vc.selec
                vc.selectedCurency.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (newValue) in
                    if let currency = newValue{
                        //this should make the vm call the API but the free API is only working with EUR
                        //So-> I make some calculations
                        self?.vm.selectedCurrency = currency
                    }
                }).disposed(by: disposeBag)
                vc.currencies = vm.masterCurrencies
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    override func binding() {
        super.binding()
        vm.loadCurenciesDone.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (_) in
            self?.currenciesTableView.reloadData()
            var c = self?.vm.selectedCurrency.name
            c?.removeLast()
            self?.label.text = "\((c ?? "").flag()) \(self?.vm.selectedCurrency.name ?? "")"
        }).disposed(by: disposeBag)
    }
    func openConverterView(currency: Currency){
        if let vc = storyboard?.instantiateViewController(identifier: "ConverterVC") as? ConverterVC{
            vc.currency = currency
            vc.vm = self.vm
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CurrenciesListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openConverterView(currency: vm.currencies[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CurrenciesListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! CurrencyCell
        let currency = vm.currencies[indexPath.row]
        cell.currencyNameLabel.text = vm.formattedNameWithFlag(currency: currency)
        cell.currencyValueLabel.text = vm.formattedNumber(currency: currency)
        return cell
    }
    
}
