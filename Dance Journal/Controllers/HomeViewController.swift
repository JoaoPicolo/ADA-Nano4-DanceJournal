//
//  HomeViewController.swift
//  Dance Journal
//
//  Created by João Pedro Picolo on 08/10/21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "appBackground")
        setLastSequenceView()
        setFavoriteSequencesView()
    }
    
    private func setLastSequenceView() {
        let title = UILabel()
        title.text = "Last Sequence"
        title.textColor = UIColor(named: "fontColor")
        title.font = UIFont(name: "Kreon-Bold", size: 30)
        view.addSubview(title)
        title.snp.makeConstraints { make -> Void in
            make.left.equalTo(30)
            make.top.equalTo(80)
        }
        
        let lastSequence = SequenceCardView().setupView(imageWidth: nil, textSize: 24)
        view.addSubview(lastSequence)
        lastSequence.snp.makeConstraints { make -> Void in
            make.top.equalTo(150)
            make.centerX.equalTo(view)
        }
    }
    
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
       let scale = newWidth / image.size.width
       let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage!
   }
    
    private func setFavoriteSequencesView() {
        let title = UILabel()
        title.text = "Favorite Sequences"
        title.textColor = UIColor(named: "fontColor")
        title.font = UIFont(name: "Kreon-Bold", size: 24)
        title.layer.zPosition = 2
        view.addSubview(title)
        title.snp.makeConstraints { make -> Void in
            make.left.equalTo(30)
            make.top.equalTo(480)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 200)
        
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor =  UIColor(named: "appBackground")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 470, left: 0, bottom: 100, right: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let seq = SequenceCardView().setupView(imageWidth: 200, textSize: 16)
        cell.addSubview(seq)
        seq.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(10 * indexPath.row)
            make.topMargin.equalTo(30)
        }
        
        return cell
    }
}
