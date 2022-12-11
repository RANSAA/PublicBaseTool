//
//  ImageCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    var image: UIImage! = UIImage.image(with: UIColor.gray) {
        didSet {
            imageView.image = image
        }
    }
    
    var test:String = ""{
        didSet{
            print("test didSet ..")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        addTap()
    }

    
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func tapAction(){
        print("ImageCell tap action ....")
    }
}
