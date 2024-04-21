//
//  ViewController.swift
//  testMultiMeadia
//
//  Created by Руслан Усманов on 11.01.2024.
//

import UIKit

class AudioViewController: UIViewController {
    
    
    private var timer: Timer? = nil
    
    private var timerClosure: (() -> Void)?
    
    private lazy var newVIew: UIView = {
        let view = MusicPlayerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        timerClosure = view.updateSlider

        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startSliderUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        setConstaints()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    
    //MARK: Private

    private func setConstaints(){
        self.view.addSubview(newVIew)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            newVIew.topAnchor.constraint(equalTo: safeArea.topAnchor),
            newVIew.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            newVIew.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            newVIew.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            ])
    }
            private func startSliderUpdate(){
                 timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] _ in
                    (self?.timerClosure ?? {print("An issue occured")})()
                })
                RunLoop.current.add(timer!, forMode: .common)
            }
    
}


