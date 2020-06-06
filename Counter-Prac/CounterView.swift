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

class CounterView: UIView {
    private let backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v;
    }()
    
    private let valueLabel: UILabel = {
        let v = UILabel()
        v.text = "0"
        v.textAlignment = .center
        return v
    }()
    
    private let increaseButton: UIButton = {
        let v = UIButton(type: .roundedRect)
        v.backgroundColor = .brown
        return v
    }()
    
    private let decreaseButton: UIButton = {
        let v = UIButton(type: .roundedRect)
        v.backgroundColor = .brown
        return v
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .medium)
        return v
    }()
    
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
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.valueLabel)
        self.backgroundView.addSubview(self.increaseButton)
        self.backgroundView.addSubview(self.decreaseButton)
        self.backgroundView.addSubview(self.activityIndicatorView)
    }
    
    private func setLayout() {
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
