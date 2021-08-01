//
//  CurrenciesListVM.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import RxSwift
import RxCocoa
import Moya

class CurrenciesListVM{
    let loadCurenciesDone: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    lazy var currencyProvider: MoyaProvider<CurrencyService> = {
        return Networking.getConfiguredMoyaProviderWith(vc: nil)
    }()
    var selectedCurrency:Currency = Currency(name: "EUR", ratio: 1.0){
        didSet{
            //TODO: call API
            //selected currency changed ---> update to new rates
            //this should make the vm call the API but the free API is only working with EUR
            //So-> I make some calculations
            var newCurrencies:[Currency] = []
            masterCurrencies.forEach { (currency) in
                if currency.name == "EGP"{
                    print("\(currency.ratio)")
                }
                newCurrencies.append(Currency(name: currency.name, ratio:  currency.ratio / selectedCurrency.ratio))
            }
            currencies = newCurrencies
            DispatchQueue.main.async { [weak self] in
                self?.loadCurenciesDone.accept(true)
            }
        }
    }
    var currencies: [Currency] = []
    var masterCurrencies:[Currency] = [] {
        didSet{
            currencies = masterCurrencies
        }
    }
    let disposeBag: DisposeBag
    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
    func convertCurrency(value: Double, currency: Currency)->Double{
        return currency.ratio*value
    }
    func fetchCurenciesList(){
        currencyProvider.rx.request(.fetchAllCurrencies(baseCurrencyCode: "EUR", loader: false))
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(RatesResponseModel.self)
            .subscribe(onNext: { (response) in
                if response.success{
                    self.masterCurrencies.removeAll()
                    response.rates.forEach { (key,val) in
                        if key == "EGP" || key == "USD" || key == "EUR"{
                            self.masterCurrencies.insert(Currency(name: key, ratio: val), at: 0)
                        }else{
                            self.masterCurrencies.append(Currency(name: key, ratio: val))
                        }
                    }
                }
                self.loadCurenciesDone.accept(true)
            })
            .disposed(by: disposeBag)
    }
    func formattedNameWithFlag(currency: Currency)->String{
        var ccode = currency.name
        ccode.removeLast()
        return ccode.flag() + "  " + currency.name
    }
    func formattedNumber(currency: Currency)->String{
        return String(format: "%\(0.5)f", currency.ratio)
    }
}

