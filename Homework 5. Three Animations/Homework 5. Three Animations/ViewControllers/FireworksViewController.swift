//
//  FireworksViewController.swift
//  Homework 5. Three Animations
//
//  Created by spezza on 01.02.2021.
//

import UIKit

class FireworksViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 52)
        label.textColor = .systemGreen
        label.text = "FIRE!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var fireworksImage: UIImageView = {
        let fireworksImage = UIImageView()
        fireworksImage.image = UIImage(named: "citycity")
        fireworksImage.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        fireworksImage.translatesAutoresizingMaskIntoConstraints = false
        return fireworksImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        view.addSubview(titleLabel)
        view.addSubview(fireworksImage)
        
        let fireworks = ParticleViews()
        fireworks.emitterType = .fireworks
        fireworks.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fireworks)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            fireworksImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fireworksImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fireworksImage.widthAnchor.constraint(equalTo: view.widthAnchor),
//            fireworksImage.heightAnchor.constraint(equalToConstant: 250),
            
            fireworks.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fireworks.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fireworks.topAnchor.constraint(equalTo: view.topAnchor),
            fireworks.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
