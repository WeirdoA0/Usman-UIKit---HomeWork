//
//  OptionsViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 17.04.2024.
//

import Foundation
import UIKit
import MapKit

class OptionsViewController: UIViewController {
    
    //MARK: Subviews
    
    private let map: MKMapView

    
    private lazy var deleteAllMarksButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete all annotations", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.backgroundColor = .systemGray6
        btn.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var mapAppearenceButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Change map appereance", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.backgroundColor = .systemGray6
        btn.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.alignment = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        [mapAppearenceButton, deleteAllMarksButton].forEach({
            stack.addArrangedSubview($0)
        })
        
        return stack
    }()
    
    //MARK: LifeCycle
    
    init(map: MKMapView) {
        self.map = map
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    //MARK: Private
    
    private func setConstraints() {
        let safe = view.safeAreaLayoutGuide
        [stackView].forEach({
            view.addSubview($0)
        })
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor,constant: -16),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16)
            
            
        ])
    }
    
    
    //MARK: Objc
    
    @objc func btnDidTap(sender: UIButton){
        switch sender {
        case deleteAllMarksButton:
           let marks =  map.annotations
            map.removeAnnotations(marks)
        case mapAppearenceButton:
            switch map.preferredConfiguration.elevationStyle {
            case .flat:
                map.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: .realistic)
            case .realistic:
                map.preferredConfiguration = MKStandardMapConfiguration(emphasisStyle: .default)
            @unknown default:
                fatalError()
            }
            

        default:
            break
        }
    }
}
