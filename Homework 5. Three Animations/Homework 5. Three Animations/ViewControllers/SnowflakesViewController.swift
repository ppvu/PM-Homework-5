//
//  SnowflakesViewController.swift
//  Homework 5. Three Animations
//
//  Created by spezza on 01.02.2021.
//

import UIKit

class SnowflakesViewController: UIViewController {
    
    lazy var gradientSkyView: UIView = {
        let sky = GradientView()
        
        sky.colors = [
            UIColor(red: 0.1, green: 0.25, blue: 0.5, alpha: 1).cgColor,
            UIColor(red: 0.75, green: 0.8, blue: 0.9, alpha: 1).cgColor
        ]
        return sky
    }()
    
    lazy var snowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Make it SNOW!", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.black.cgColor

        button.addTarget(self, action: #selector(snowBlind), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var snow: ParticleViews = {
        let snow = ParticleViews()
        snow.emitterType = .snow
        return snow
    }()
    
    var showSnow: Bool = false {
        didSet {
            snow.isHidden = !showSnow
            let color = showSnow ? UIColor.systemRed : UIColor.systemBlue
            let title = showSnow ? "STOP IT!" : "MAKE IT SNOW!"
            
            snowButton.setTitleColor(color, for: .normal)
            snowButton.setTitle(title, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
   
    private func setup() {
        view.backgroundColor = .white
        view.insertSubview(gradientSkyView, at: 0)
        
        view.addSubview(snow)
        view.addSubview(snowButton)
        
        gradientSkyView.translatesAutoresizingMaskIntoConstraints = false
        snow.translatesAutoresizingMaskIntoConstraints = false
        
        showSnow = false
        
        NSLayoutConstraint.activate([
            gradientSkyView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientSkyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientSkyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientSkyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            snowButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            snowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            snowButton.heightAnchor.constraint(equalToConstant: 40),
            snowButton.widthAnchor.constraint(equalToConstant: 120),
            
            snow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snow.topAnchor.constraint(equalTo: view.topAnchor),
            snow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func snowBlind() {
        showSnow.toggle()
    }
}
