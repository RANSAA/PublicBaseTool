//
//  ContentCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/29.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class ContentCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    public var onClickLabel: ((UICollectionViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //TK Add Test
//        addLabelTapGesture()
    }
    
    func addLabelTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickLabelAction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
    }
    
    @objc func clickLabelAction(){
        print("ContentCell Label Click...")
        onClickLabel?(self)
    }
    
    

    //TK Add Test
    /**
     计算最多指定行文本的高度,默认3行
     */
    static func fixedHeight(for text: NSString,limitwidth: CGFloat, maxLine:Int = 2) -> CGFloat{
        var h = height(for: text, limitwidth: limitwidth)
        var line = Int(h/lineHeight())
        line = line > maxLine ? maxLine : line
        h = CGFloat(line) * lineHeight()
        return ceil(h);
    }
    
    static func lineHeight() -> CGFloat {
        return UIFont.systemFont(ofSize: 16).lineHeight
    }
    
   static func height(for text: NSString,limitwidth: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let size: CGSize = CGSize(width: limitwidth - 20, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:font], context: nil)
        return ceil(rect.height)
    }
}

extension ContentCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let vm = viewModel as? String else { return }
        self.label.text = vm
    }
}
