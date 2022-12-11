//
//  ImageCollectionCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/5.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class ImageCollectionCell: UICollectionViewCell {

    let padding: CGFloat = 10

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: ImagesCollectionCellModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: ImageCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.cellIdentifier)
    }

    

}


/**
 处理点击collectionView空白区域(cell之外的区域)时，将event直接向上传递。
 让外层的cell能接受到selected事件
 */
extension ImageCollectionCell{
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //将point转化到collectionView上
        let collectionViewPoint = collectionView.convert(point, from: self)
        //判断事件是否发生在collectionView区域内
        if collectionView.point(inside: collectionViewPoint, with: event) {
            for  subView in collectionView.subviews {
                let subViewPoint = subView.convert(point, from: self)
                if subView.point(inside: subViewPoint, with: event) {
                    return subView
                }
            }
            return self
        }
        return super.hitTest(point, with: event)
    }
}

extension ImageCollectionCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ImagesCollectionCellModel else { return }
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension ImageCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = self.viewModel?.images else {
            return 0
        }
        return images.count
//        return (self.viewModel?.images.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellIdentifier, for: indexPath) as? ImageCell else { fatalError() }
        cell.image = self.viewModel?.images[indexPath.item]
        return cell
    }
}

extension ImageCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - padding * 2) / 3
        return CGSize(width: width, height: width)
    }
}


extension ImageCollectionCell:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ImageSectionController ImageCollectionCell CollectionCell didSelectItemAt:\(indexPath)")
    }
}
