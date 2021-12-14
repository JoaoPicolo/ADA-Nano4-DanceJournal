//
//  HomeViewController.swift
//  Dance Journal
//
//  Created by João Pedro Picolo on 08/10/21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private lazy var mainView: UIView = {
        let view = UIView()
        
        let title = UILabel()
        title.text = "Last Sequence"
        title.textColor = UIColor(named: "fontColor")
        title.font = UIFont(name: "Kreon-Bold", size: 30)
        view.addSubview(title)

        title.snp.makeConstraints { make -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(80)
            make.leading.equalTo(20)
        }
        
        return view
    }()
    
    private lazy var secondaryView: UIView = {
        let view = UIView()
        
        let title = UILabel()
        title.text = "Favorite Sequences"
        title.textColor = UIColor(named: "fontColor")
        title.font = UIFont(name: "Kreon-Bold", size: 24)
        view.addSubview(title)

        title.snp.makeConstraints { make -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(24)
            make.top.equalTo(20)
            make.leading.equalTo(20)
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
    }
    
    private func setupHierarchy() {
        view.backgroundColor = UIColor(named: "appBackground")
        
        view.addSubview(mainView)
        view.addSubview(secondaryView)
        
        setupMainView()
        setupSecondaryView()
    }
    
    private func setupMainView() {
        mainView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-300)
        }

        // Image will fill 35% of view's height
        let lastSequence = SequenceCardView().createSequenceCard(imageWidth: (view.frame.height * 0.35), textSize: 24)
        mainView.addSubview(lastSequence)

        lastSequence.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(160)
        }
    }
    
    private func setupSecondaryView() {
        secondaryView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(0)
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
        secondaryView.addSubview(collectionView)

        collectionView.snp.makeConstraints { make -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(240)
            make.top.equalTo(60)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 90, left: 90, bottom: 90, right: 90)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let seq = SequenceCardView().createSequenceCard(imageWidth: 200, textSize: 16)
        cell.addSubview(seq)
        seq.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(10 * indexPath.row)
        }
        
        return cell
    }
}
