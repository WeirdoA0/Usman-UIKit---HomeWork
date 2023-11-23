//
//  File.swift
//  Navigation
//
//  Created by Руслан Усманов on 27.10.2023.
//

import UIKit
import iOSIntPackage
import StorageService

class PhotosViewController: UIViewController {
    
    private var facade = ImagePublisherFacade()
    private var imageList: [UIImage] = makeUIImageArray(type: .empty)
    
    //MARK: Constants
    private enum Constants {
        static let vertSpacing: CGFloat = 8
    }
    
    
    //MARK: Subviews
    
    private lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cltn = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cltn.translatesAutoresizingMaskIntoConstraints = false
        
        cltn.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        
        //MARK: Uncomment later
        cltn.delegate = self
        cltn.dataSource = self
        
        return cltn
    }()
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        addSubviews()
        setConstraints()
        subscribe()
        facade.addImagesWithTimer(time: 0.2, repeat: 21, userImages: makeUIImageArray(type: .normal))

    }

    
    // MARK: Private
    private func setView() {
        view.backgroundColor = .white
        title = "Photo Gallery"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    private func addSubviews(){
        view.addSubview(photoCollection)
    }
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            photoCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.vertSpacing),
            photoCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.vertSpacing),
            photoCollection.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.vertSpacing),
            photoCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.vertSpacing)
        ])
    }
    private func subscribe() {
        facade.subscribe(self)
    }
}

// MARK: Delegate


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
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
        return 7
    }
}

//MARK: DataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("Fatal Error of gallery")
        }
        cell.update(image: imageList[
            indexPath.section*3 + indexPath.row
        ]
        )
        
        return cell
    }
    
    
}

//MARK: ImageLibrarySubscriber

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        imageList[images.count-1] = images.last!
        photoCollection.reloadData()
                
        if images.count == 21 {
            facade.removeSubscription(for: self)
        }
    }
}

