//
//  ConfettiViewController.swift
//  Homework 5. Three Animations
//
//  Created by spezza on 01.02.2021.
//

import UIKit

class ConfettiViewController: UIViewController {
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 52)
        label.textColor = .systemYellow
        label.text = "Party Time!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var partyImage: UIImageView = {
        let partyImage = UIImageView()
        partyImage.image = UIImage(named: "birthday-cake")
        
        partyImage.translatesAutoresizingMaskIntoConstraints = false
        return partyImage
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        view.addSubview(titleLable)
        view.addSubview(partyImage)
        
        let confetti = ParticleViews()
        confetti.emitterType = .confetti
        confetti.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confetti)
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            partyImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            partyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            partyImage.widthAnchor.constraint(equalToConstant: 250),
            partyImage.heightAnchor.constraint(equalToConstant: 250),
            
            confetti.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confetti.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            confetti.topAnchor.constraint(equalTo: view.topAnchor),
            confetti.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
