//
//  SwipeController+UIButton.swift
//  Kalm
//
//  Created by Klaudius Ivan on 22/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//
import UIKit
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
    
    
    // Mark : - Button Delegate Function
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
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as UIViewController?
            self.present(vc!, animated: true, completion: nil)
        }
    }
}
