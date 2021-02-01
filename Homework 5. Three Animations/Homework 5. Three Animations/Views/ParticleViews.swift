//
//  ParticleViews.swift
//  Homework 5. Three Animations
//
//  Created by spezza on 01.02.2021.
//

import UIKit

class ParticleViews: UIView {
    
    enum EmitterType {
        case snow, confetti, fireworks
    }
    
    var emitterType: EmitterType? {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override func layoutSubviews() {
        let emitter = layer as! CAEmitterLayer
        
        switch emitterType {
        case .snow:
            emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -10)
            emitter.emitterShape = .line
            
            let start = generateSnow(imageName: "circle", color: UIColor(white: 1, alpha: 1), velocity: 120, scale: 0.4)
            let middle = generateSnow(imageName: "snow", color: UIColor(white: 1, alpha: 0.5), velocity: 100, scale: 0.2)
            let end = generateSnow(imageName: "spark", color: UIColor(white: 1, alpha: 0.2), velocity: 80, scale: 0.1)

            emitter.emitterCells = [start, middle, end]
            
        case .confetti:
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -10)
            emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
            emitter.emitterShape = .line
            
            var emitterCells = [CAEmitterCell]()

            emitterCells = generateConfetti()
            
            emitter.emitterCells = emitterCells
        
        case .fireworks:
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY - 100)
            emitter.emitterShape = .point

            emitter.emitterCells = [generateFireworks(birthRate: 2.4)]
//                                    generateFireworks(birthRate: 1.2),
//                                    generateFireworks(birthRate: 0.6)]
            
        default:
            break
        }
    }
    
    private func generateSnow(imageName: String, color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 30
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = velocity
        cell.velocityRange = velocity / 5
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 10
        cell.scale = scale
        cell.scaleRange = scale / 4

        cell.contents = UIImage(named: imageName)?.cgImage
        return cell
    }
    
    private func generateConfetti() -> [CAEmitterCell] {
        
        let images = [
            UIImage(named: "circle"),
            UIImage(named: "confetti"),
            UIImage(named: "star")
        ]
        
        let colors: [UIColor] = [
            .systemYellow,
            .systemGreen,
            .systemRed,
            .systemBlue,
            .systemPink,
            .systemOrange,
        ]
        
        var cells = [CAEmitterCell]()
        for _ in 0...15 {
            let cell = CAEmitterCell()
            
            cell.birthRate = 4
            cell.lifetime = 45
            cell.lifetimeRange = 0
            cell.velocity = 50
            cell.yAcceleration = 60
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 1
            cell.spin = 0
            cell.spinRange = 6
            cell.color = colors.randomElement()!.cgColor
            cell.scaleRange = 0.6
            cell.scale = 0.9
            cell.alphaRange = 0.4
            cell.contents = images.randomElement()!?.cgImage
            
            cell.setValue("plane", forKey: "particleType")
            cell.setValue(Double.pi, forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")
            
            cells.append(cell)
        }
        
        return cells
    }
    
    private func generateFireworks(birthRate: Float) -> CAEmitterCell {
        let cell = CAEmitterCell()
        
        cell.birthRate = birthRate
        cell.lifetime = 4
        cell.lifetimeRange = 0
        cell.velocity = 300
        cell.velocityRange = 175
        cell.yAcceleration = 80
        cell.emissionLongitude = -90 * (.pi / 180)
        cell.emissionRange = 30 * (.pi / 180)
        cell.scale = 0
        cell.color = UIColor.white.cgColor
        cell.redRange = 1
        cell.greenRange = 1
        cell.blueRange = 1
        
        let trailCell = CAEmitterCell()
        trailCell.contents = UIImage(named: "circle")?.cgImage
        trailCell.birthRate = 60
        trailCell.lifetime = 1
        trailCell.beginTime = 0
        trailCell.duration = 2
        trailCell.velocity = 80
        trailCell.velocityRange = 75
        trailCell.velocityRange = 150
        trailCell.xAcceleration = 150
        trailCell.yAcceleration = 450
        trailCell.emissionLongitude = -360 * (.pi / 180)
        trailCell.emissionRange = 10 * (.pi / 180)
        trailCell.scale = 1
        trailCell.scaleSpeed = 0.3
        trailCell.alphaSpeed = -1
        
        let explosionCell = CAEmitterCell()
        explosionCell.contents = UIImage(named: "circle")?.cgImage
        explosionCell.birthRate = 10000
        explosionCell.lifetime = 15
        explosionCell.beginTime = 2
        explosionCell.duration = 0.1
        explosionCell.velocity = 150
        explosionCell.velocityRange = 70
        explosionCell.yAcceleration = 80
        explosionCell.emissionRange = 360 * (.pi / 180)
        explosionCell.spin = 100 * (.pi / 180)
        explosionCell.scale = 1.5
        explosionCell.scaleSpeed = 0.15
        explosionCell.alphaSpeed = -0.7
        
        cell.emitterCells = [trailCell, explosionCell]
        
        return cell
    }
}
