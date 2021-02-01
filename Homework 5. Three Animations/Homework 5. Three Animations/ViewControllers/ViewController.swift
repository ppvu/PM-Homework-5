//
//  ViewController.swift
//  Homework 5. Three Animations
//
//  Created by spezza on 01.02.2021.
//

import UIKit

class ViewController: UIViewController {

    let pages = [
        SnowflakesViewController(),
        ConfettiViewController(),
        FireworksViewController()
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = view.frame.size
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        cv.backgroundColor = .systemBackground
        
        cv.delegate = self
        cv.dataSource = self
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        
        pc.pageIndicatorTintColor = UIColor.label.withAlphaComponent(0.4)
        pc.currentPageIndicatorTintColor = .label
        
        pc.addTarget(nil, action: #selector(changer), for: .valueChanged)
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setups()
    }
    
    private func setups() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        setLayoutConstrains()
    }
    
    private func setLayoutConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
   
}

extension ViewController {
    @objc func changer() {
        let index = IndexPath(row: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let cellViewController = pages[indexPath.row]
        cellViewController.view.frame = cell.bounds
        cell.addSubview(cellViewController.view)
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(index)
    }
}

