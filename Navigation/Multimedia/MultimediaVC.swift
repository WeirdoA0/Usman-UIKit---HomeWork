//
//  MultimediaVC.swift
//  Navigation
//
//  Created by Амир on 14.01.2024.
//

import Foundation
import UIKit


class MultimediaVeiwController: UIViewController{
    
    
    //MARK: Subviews
    private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            
            let cltn = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
            cltn.translatesAutoresizingMaskIntoConstraints = false
            
            cltn.register(MultimediaCollectionViewCel.self, forCellWithReuseIdentifier: MultimediaCollectionViewCel.identifier)
            
            cltn.delegate = self
            cltn.dataSource = self
            
            return cltn
        }()
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        addSubviews()
        setConstraints()
        
    }
    
    //MARK: Private
    private func setView() {
        view.backgroundColor = .white
        title = "Multimedia"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    private func addSubviews(){
        view.addSubview(collectionView)
    }
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.vertSpacing),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.vertSpacing),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.vertSpacing),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.vertSpacing)
        ])
    }
}

extension MultimediaVeiwController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MultimediaCollectionViewCel.identifier,
            for: indexPath) as? MultimediaCollectionViewCel else {
            fatalError("Fatal Error ")
        }
        if indexPath.row + indexPath.section*3 < 2 {
            cell.update(image:
                            [UIImage(named:"music"),UIImage(named:"video"),UIImage(named: "microphone")][indexPath.section*3+indexPath.row]!)
        }
        
        return cell
    }
    
}

extension MultimediaVeiwController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 32)/3
        return CGSize(width: size*0.9, height: size*0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.vertSpacing, left: Constants.vertSpacing, bottom: Constants.vertSpacing, right: Constants.vertSpacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.vertSpacing
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row + indexPath.section*3 {
        case 0:
   
            navigationController?.pushViewController(AudioViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(VideoViewController(), animated: true)
        case 2:
            break
        default:
            break
        }
    }
}

//MARK: Constants
private enum Constants {
    static let vertSpacing: CGFloat = 8
}
