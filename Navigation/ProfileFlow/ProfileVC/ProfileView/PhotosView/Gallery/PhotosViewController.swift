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
    
    
    private var imageProcessor = ImageProcessor()
    private var imageList: [UIImage] = makeUIImageArray(type: .normal)

    
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
        processImagesOnThread()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    private func processImagesOnThread(){
        let startDate = Date()
        ImageProcessor().processImagesOnThread(sourceImages: makeUIImageArray(type: .normal),
                                                      filter: .posterize,
                                                      qos: .default) { [weak self] images in
                   guard let self else { return }
                   self.imageList = images
                       .compactMap { $0 }
                       .map { UIImage(cgImage: $0) }
                   DispatchQueue.main.async {
                       self.photoCollection.reloadData()
                   }
                   print("Process time:  \(Date().timeIntervalSince(startDate)) seconds")
               }
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
        var number = imageList.count / 3
        if imageList.count - number*3 > 0 {
            number += 1
        }
        return number
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
        if (indexPath.section*3 + indexPath.row) < imageList.count {
        cell.update(image: imageList[
            indexPath.section*3 + indexPath.row
        ])
                    } else {
            cell.update(image: UIImage())
        }
        
        return cell
    }
    
}


// default 1.724923014640808
// background 4.937456011772156
// utility  1.852594017982483
// userInitiated 1.6242889165878296
// userInteractive 1.4245660305023193
