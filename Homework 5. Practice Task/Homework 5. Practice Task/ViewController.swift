//
//  ViewController.swift
//  Homework 5. Practice Task
//
//  Created by spezza on 01.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var shapeLayers = createShapeLayer(layersQuantity: 3)
    
    lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.tintColor = .white
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        return startButton
    }()
    
    lazy var stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopButton.tintColor = .white
        stopButton.addTarget(self, action: #selector(stopAnimations), for: .touchUpInside)
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        return stopButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAnimations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        shapeLayers.forEach { $0.frame = view.bounds }
        shapeLayers.forEach { $0.anchorPoint = CGPoint(x: 0.5, y: 0.5)}
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemTeal
        view.addSubview(startButton)
        view.addSubview(stopButton)
        
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -270),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 50),
            
            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
            stopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -270),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        shapeLayers.forEach { view.layer.addSublayer($0) }
    }
    
    private func createShapeLayer(layersQuantity: Int) -> [CALayer] {
        
        var layers = [CALayer]()
        
        for _ in 1...layersQuantity {
            let shapeLayer = CAShapeLayer()
            
            let circle = UIBezierPath(arcCenter: view.center,
                                      radius: 70,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true)
            shapeLayer.path = circle.cgPath
            shapeLayer.fillColor = UIColor.red.cgColor
            shapeLayer.opacity = 0
            
            layers.append(shapeLayer)
        }
        
        return layers
        
    }
    
    private func setupAnimations() {
        shapeLayers.enumerated().forEach { (index, layer) in
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0
            scaleAnimation.toValue = 1
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [opacityAnimation, scaleAnimation]
            
            animationGroup.duration = 1.5
            animationGroup.repeatCount = .infinity
            animationGroup.beginTime = CACurrentMediaTime() + 0.4 * Double(index)
            
            layer.add(animationGroup, forKey: "animationGroup")
        }
    }
    
    @objc private func startButtonAction() {
        setupAnimations()
    }
    
    @objc private func stopAnimations() {
        if let sublayers = view.layer.sublayers {
            for layer in sublayers {
                layer.removeAllAnimations()
            }
        }
    }
}

