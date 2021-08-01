//
//  BaseVC.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class BaseVC: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    let loaderIndicatorHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    var loadingContainer: UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
    }
    
    func binding() {
        loaderIndicatorHidden.asObservable().observeOn(MainScheduler.instance).bind(to: self.loadingContainer.rx.isHidden).disposed(by: disposeBag)
        loaderIndicatorHidden.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (_) in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    func setupUI() {
        setupLoaderIndicator()
    }
    func setupLoaderIndicator() {
        loadingContainer = UIView(frame: UIScreen.main.bounds)
        loadingContainer.backgroundColor = .yellow
        loadingContainer.isUserInteractionEnabled = true
        loadingContainer.isHidden = true

        let loaderIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 72, height: 72))
        loaderIndicator.backgroundColor = .white
        loaderIndicator.layer.cornerRadius = 12
    
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.ballTrianglePath, color: .red, padding: nil)
        activityIndicator.backgroundColor = .clear
        activityIndicator.startAnimating()
        loaderIndicator.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(loaderIndicator)
                
        loaderIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingContainer)
        view.bringSubviewToFront(loadingContainer)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: loaderIndicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 72),
            NSLayoutConstraint(item: loaderIndicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 72),
            NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: loaderIndicator, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: loaderIndicator, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loaderIndicator, attribute: .centerY, relatedBy: .equal, toItem: loadingContainer, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loaderIndicator, attribute: .centerX, relatedBy: .equal, toItem: loadingContainer, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loadingContainer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loadingContainer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loadingContainer, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loadingContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }
}
