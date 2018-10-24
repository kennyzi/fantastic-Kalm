//
//  SwipeController.swift
//  Kalm
//
//  Created by Klaudius Ivan on 04/06/18.
//  Copyright © 2018 Klaudius. All rights reserved.
//

import UIKit

class SwipeController:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variables
    private var nextButton = UIButton()
    private var prevButton = UIButton()
    
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton = self.createNextUIButton()
        prevButton = self.createPrevUIButton()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
        setupBottomControls()
        pageControl.currentPage = 0
        pageControl.numberOfPages = tutorialImageName.count
        pageControl.currentPageIndicatorTintColor = UIColor(displayP3Red: 248/255, green: 162/255, blue: 118/255, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor(displayP3Red: 255/255, green: 211/255, blue: 189/255, alpha: 1)
        prevButton.setTitleColor(.clear, for: .normal)
        prevButton.isEnabled = false
        
    }
    
    
    // MARK: - Page Controller
    private var pageControl = UIPageControl()
    
    let tutorialImageName = ["First Page","Second Page","Third Page","Fourth Page","Fifth Page","Sixth Page"]
    fileprivate func setupBottomControls() {
        let bottomControlStackView = UIStackView(arrangedSubviews: [prevButton,pageControl,nextButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        view.addSubview(bottomControlStackView)
        NSLayoutConstraint.activate([bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    
    // MARK: - Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorialImageName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let imageName = tutorialImageName[indexPath.item]
        cell.tutorialImageView.image = UIImage(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

// MARK: - Button Delegate
extension SwipeController{
    func createPrevUIButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        return button
    }
    
    func createNextUIButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if pageControl.currentPage == 0{
            prevButton.setTitleColor(.clear , for: .normal)
            prevButton.isEnabled = false
        }
        else {
            prevButton.setTitleColor(.gray, for: .normal)
            prevButton.isEnabled = true
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @objc private func handleNext() {
        if nextButton.currentTitle == "Next"{
            let nextIndex = min(pageControl.currentPage + 1, tutorialImageName.count - 1)
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if pageControl.currentPage == tutorialImageName.count - 1{
                nextButton.setTitle("Done", for: .normal)
            }
            else {
                prevButton.setTitleColor(.gray, for: .normal)
                prevButton.isEnabled = true
                nextButton.setTitle("Next", for: .normal)
            }
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as UIViewController?
            let navigationController = UINavigationController(rootViewController: vc!)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}

