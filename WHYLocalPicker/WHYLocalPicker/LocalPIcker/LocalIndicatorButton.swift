//
//  LocalIndicatorButton.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/19.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

class LocalIndicatorButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefalut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupDefalut() {
        setTitle("请选择", forState: .Normal)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(14)
//        setTitleColor(UIColor.redColor(), forState: .Selected)
    }

}
