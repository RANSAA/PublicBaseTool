//
//  ContentSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/29.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class ContentSectionController: ListSectionController {
    var object: Feed!
    var expanded: Bool = false
    
    override init() {
        super.init()
        
    }

    override func numberOfItems() -> Int {
        if object.content?.isEmpty ?? true {
            return 0
        }
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let content = object.content else { return CGSize.zero }
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        
//        let height = expanded ? ContentCell.height(for: content as NSString, limitwidth: width) : ContentCell.lineHeight()
        
        let allHeight = ContentCell.height(for: content as NSString, limitwidth: width)
        let fixedHeight = ContentCell.fixedHeight(for: content as NSString, limitwidth: width, maxLine: 1)//指定最多显示一行
        
        let height = expanded ? allHeight : fixedHeight
        
        return CGSize(width: width, height: height + 5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: ContentCell.cellIdentifier, bundle: nil, for: self, at: index) as? ContentCell else { fatalError() }

        cell.bindViewModel(object.content as Any)
        
        //TK Add Test
        cell.onClickLabel = { [weak self] cell in
            guard let self = self else { return }
            self.expandedLabelAction()
        }
        
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
    }

    override func didSelectItem(at index: Int) {
        expanded.toggle()
        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.4, initialSpringVelocity: 0.6, options: [], animations: {
//            self.collectionContext?.invalidateLayout(for: self, completion: nil)
//        }, completion: nil)
        
        self.collectionContext?.performBatch(animated: true, updates: { (batch) in
            batch.reload(in: self, at: IndexSet(integer: 0))
        }, completion: nil)
    }
    
    //TK Add Test
    func expandedLabelAction(){
        print("ContentSectionController: expandedLabelAction...")
        expanded.toggle()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.4, initialSpringVelocity: 0.6, options: [], animations: {
            self.collectionContext?.invalidateLayout(for: self, completion: nil)
        }, completion: nil)
    }
}
