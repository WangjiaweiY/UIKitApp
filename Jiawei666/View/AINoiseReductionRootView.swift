//
//  ViewControllerView.swift
//  RTCubeApp
//
//  Created by joewwwang on 2024/5/23.
//  Copyright © 2024 Tencent. All rights reserved.
//

import UIKit


class AINoiseReductionRootView: UIView {
    
    let viewModel: AINoiseReductionViewModel
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.sizeToFit()
        button.backgroundColor = .white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 22
        button.tintColor = .black
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.text = "小小demo。。。"
        return label
    }()
    
    lazy var micOrStopButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.setBackgroundImage(UIImage(systemName: "mic.circle"), for: .normal)
        return button
    }()
    
    lazy var playOrPauseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        return button
    }()
    
    lazy var headPhonesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.setBackgroundImage(UIImage(systemName: "headphones.circle"), for: .normal)
        return button
    }()

    init(viewModel: AINoiseReductionViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        constructViewHierarchy()
        activateConstraints()
        bindInteraction()
    }
}

extension AINoiseReductionRootView {
    
    func constructViewHierarchy() {
        addSubview(textLabel)
        addSubview(micOrStopButton)
        addSubview(playOrPauseButton)
        addSubview(headPhonesButton)
        
        addSubview(backButton)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.purple.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func activateConstraints() {
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            micOrStopButton.widthAnchor.constraint(equalToConstant: 100),
            micOrStopButton.heightAnchor.constraint(equalToConstant: 100),
            micOrStopButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -120),
            micOrStopButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            playOrPauseButton.widthAnchor.constraint(equalToConstant: 100),
            playOrPauseButton.heightAnchor.constraint(equalToConstant: 100),
            playOrPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playOrPauseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            headPhonesButton.widthAnchor.constraint(equalToConstant: 100),
            headPhonesButton.heightAnchor.constraint(equalToConstant: 100),
            headPhonesButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 120),
            headPhonesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            textLabel.widthAnchor.constraint(equalToConstant: 200),
            textLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func bindInteraction() {
        
        micOrStopButton.tag = 0
        micOrStopButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        playOrPauseButton.tag = 1
        playOrPauseButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        headPhonesButton.tag = 2
        headPhonesButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        backButton.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let buttonIndex = sender.tag
        switch buttonIndex {
        case 0:
            if sender.currentBackgroundImage == UIImage(systemName: "stop.circle") {
                sender.setBackgroundImage(UIImage(systemName: "mic.circle"), for: .normal)
                updateTextLabel(with: "声音录制暂停")
            } else {
                sender.setBackgroundImage(UIImage(systemName: "stop.circle"), for: .normal)
                updateTextLabel(with: "声音录制中。。。")
            }

        case 1:
            if sender.currentBackgroundImage == UIImage(systemName: "play.circle") {
                sender.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
                updateTextLabel(with: "正在播放")
            } else {
                sender.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                updateTextLabel(with: "暂停播放")
            }

        case 2:
            updateTextLabel(with: "实时降噪中。。。")
        default:
            break
        }
    }

    @objc
    private func backButtonClick(sender: UIButton) {

    }

    func updateTextLabel(with text: String) {
        textLabel.text = text
    }
}

