//
//  ViewController.swift
//  Swipe_to_action_button
//
//  Created by Viktor Golovach on 12.10.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    private var swipeButton: SwipeToActionButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupSwipeButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeButton.center = self.view.center
    }
    
    
    // MARK: - Methods
    private func setupSwipeButton() {
        swipeButton = SwipeToActionButton()
        swipeButton.delegate = self
        swipeButton.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width - 48,
            height: 64)
        self.view.addSubview(swipeButton)
    }
}

// MARK: - SlideToActionButtonDelegate
extension ViewController: SlideToActionButtonDelegate {
    func didFinish() {
        // Do action once button was swiped
        view.backgroundColor = .systemMint
    }
}
