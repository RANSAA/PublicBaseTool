//
//  BaseListViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class BaseListViewController: UIViewController {

    var objects: [ListDiffable] = [ListDiffable]()

    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
//        collectionView.bounces = true
//        collectionView.bouncesZoom = true
        return collectionView
    }()
   lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        return adapter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.collectionViewDelegate = self
        
        self.title = "\(type(of: self))"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}

extension BaseListViewController : ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        print("object count:\(objects.count)")
       return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ListSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}


extension BaseListViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Main CollectionView Cell didSelectItemAt:\(indexPath)")
    }
}
