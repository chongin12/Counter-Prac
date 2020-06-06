//
//  CounterView.swift
//  Counter-Prac
//
//  Created by 정종인 on 2020/06/06.
//  Copyright © 2020 swmaestro10th. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ReactorKit
import RxCocoa

class CounterView: UIView {
    weak var vc: CounterViewController?
    
    init(controlBy viewController: CounterViewController) {
        self.vc = viewController
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let baseView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private let backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private let valueLabel: UILabel = {
        let v = UILabel()
        v.text = "0"
        v.textAlignment = .center
        return v
    }()
    
    private let increaseButton: UIButton = {
        let v = UIButton(type: .roundedRect)
        v.setTitle("+", for: .normal)
        return v
    }()
    
    private let decreaseButton: UIButton = {
        let v = UIButton(type: .roundedRect)
        v.setTitle("-", for: .normal)
        return v
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .medium)
        return v
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func setup() {
        setupUI()
        setBind()
    }
    
}

extension CounterView {
    private func setupUI() {
        addSubviews()
        setLayout()
    }
    
    private func setBind() {
        //delegate, datasource
    }
    
    private func addSubviews() {
        self.addSubview(self.baseView)
        self.baseView.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.valueLabel)
        self.backgroundView.addSubview(self.increaseButton)
        self.backgroundView.addSubview(self.decreaseButton)
        self.backgroundView.addSubview(self.activityIndicatorView)
    }
    
    private func setLayout() {
        self.baseView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        self.backgroundView.snp.makeConstraints {
            $0.top.left.bottom.right.equalTo(safeAreaLayoutGuide)
        }
        self.valueLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(45)
        }
        self.increaseButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(-30)
            $0.width.height.equalTo(45)
        }
        self.decreaseButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(30)
            $0.width.height.equalTo(45)
        }
        self.activityIndicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(valueLabel).offset(30)
            $0.width.height.equalTo(45)
        }
    }
}

extension CounterView: View {
    func bind(reactor: CounterViewReactor) {
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        
    }
}
