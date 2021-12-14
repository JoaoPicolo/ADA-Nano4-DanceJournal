//
//  SequenceCardViewController.swift
//  Dance Journal
//
//  Created by João Pedro Picolo on 12/10/21.
//

import UIKit
import SnapKit

class SequenceCardView: UIView {
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSequenceCard(imageWidth: CGFloat?, textSize: CGFloat) -> UIImageView {
        let sequenceView = UIImageView()
        sequenceView.isUserInteractionEnabled = true
        sequenceView.layer.cornerRadius = 10
        sequenceView.layer.shadowRadius = 10
        sequenceView.layer.shadowOpacity = 0.5
        sequenceView.layer.shadowOffset = CGSize.zero
        sequenceView.layer.shadowColor = UIColor.black.cgColor

        var image = UIImage(named: "dance1")
        if imageWidth != nil {
            image = resizeImage(image: image!, newWidth: imageWidth!)
        }
        sequenceView.image = image
        
        let maskView = UIView(frame: CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height))
        maskView.layer.cornerRadius = 10
        maskView.backgroundColor = UIColor(named: "maskColor")
        sequenceView.addSubview(maskView)
        
        let maskText = UILabel()
        maskText.numberOfLines = 0
        maskText.textAlignment = .center
        maskText.lineBreakMode = .byWordWrapping
        maskText.text = "St. Luis Dance Ballet"
        maskText.textColor = UIColor(named: "maskFontColor")
        maskText.font = UIFont(name: "KulimPark-SemiBoldItalic", size: textSize)
        maskView.addSubview(maskText)
        maskText.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-5)
        }
        
        return sequenceView
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
}

