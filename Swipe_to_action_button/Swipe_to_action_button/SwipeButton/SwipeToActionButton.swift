//
//  SlideToActionButton.swift
//  Swipe_to_action_button
//
//  Created by Viktor Golovach on 12.10.2023.
//

import UIKit

protocol SlideToActionButtonDelegate: AnyObject {
    func didFinish()
}

class SwipeToActionButton: UIView {
    // MARK: - Properties
    private let handleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
        
    private let handleViewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(
            systemName: "arrowshape.forward.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(
                ofSize: 32,
                weight: .medium)))?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    private let draggedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 24,
            weight: .semibold)
        label.text = "Slide me!"
        return label
    }()
    
    private var leadingThumbnailViewConstraint: NSLayoutConstraint?
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var xEndingPoint: CGFloat {
        return (bounds.width - handleView.bounds.width)
    }
    private var isFinished = false
    
    // MARK: - Delegate
    weak var delegate: SlideToActionButtonDelegate?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupConstraints()
        updateHandleXPosition(4)
    }
    
    // MARK: - Methods
    private func setup() {
        backgroundColor = .clear
        layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        layer.borderWidth = 2
        addSubview(titleLabel)
        addSubview(draggedView)
        addSubview(handleView)
        handleView.addSubview(handleViewImage)
        leadingThumbnailViewConstraint = handleView.leadingAnchor.constraint(equalTo: leadingAnchor)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func setupConstraints() {
        self.rounded(self.frame.height / 2, corners: .all)
        handleView.rounded((self.frame.height - 8) / 2, corners: .all)
        draggedView.rounded((self.frame.height - 8) / 2, corners: .all)
        NSLayoutConstraint.activate([
            leadingThumbnailViewConstraint!,
            handleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            handleView.widthAnchor.constraint(equalToConstant: self.frame.height - 8),
            handleView.heightAnchor.constraint(equalToConstant: self.frame.height - 8),
            draggedView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            draggedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            draggedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            draggedView.trailingAnchor.constraint(equalTo: handleView.trailingAnchor),
            handleViewImage.topAnchor.constraint(equalTo: handleView.topAnchor, constant: 10),
            handleViewImage.bottomAnchor.constraint(equalTo: handleView.bottomAnchor, constant: -10),
            handleViewImage.centerXAnchor.constraint(equalTo: handleView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateHandleXPosition(_ x: CGFloat) {
        leadingThumbnailViewConstraint?.constant = x
    }
    
    private func reset() {
        isFinished = false
        updateHandleXPosition(4)
    }
    
    // MARK: - Actions
    @objc
    private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        if isFinished { return }
        let translatedPoint = sender.translation(in: self).x
        
        switch sender.state {
        case .changed:
            if translatedPoint <= 0 {
                updateHandleXPosition(4)
            } else if translatedPoint >= xEndingPoint {
                updateHandleXPosition(xEndingPoint)
            } else {
                updateHandleXPosition(translatedPoint)
            }
        case .ended:
            if translatedPoint >= xEndingPoint {
                self.updateHandleXPosition(xEndingPoint)
                isFinished = true
                delegate?.didFinish()
            } else {
                UIView.animate(withDuration: 1) {
                    self.reset()
                }
            }
        default:
            break
        }
    }
}
