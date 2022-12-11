//
//  FirstListViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class FirstListViewController: BaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let data = try JsonTool.decode([Feed].self, jsonfileName: "data1")
            //添加数据源时可以先检查是否有重复的数据，可通过isEqualToDiffableObject方法判断
            self.objects.append(contentsOf: data)
            
//            let data2 = try JsonTool.decode([Feed].self, jsonfileName: "data1")
//            self.objects.append(contentsOf: data2)
            
//            let data3 = try JsonTool.decode([Feed].self, jsonfileName: "data1")
//            self.objects.append(contentsOf: data3)
            
            //更新适配器数据
            adapter.performUpdates(animated: true, completion: nil)
        } catch {
            print("decode failure")
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
//        let stack = ListStackedSectionController(sectionControllers: [UserInfoSectionController(),ContentSectionController(),UserInfoSectionController()])
        let stack = ListStackedSectionController(sectionControllers: [UserInfoSectionController(),ContentSectionController()])

        stack.inset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        print("listAdapter...")
        return stack
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
