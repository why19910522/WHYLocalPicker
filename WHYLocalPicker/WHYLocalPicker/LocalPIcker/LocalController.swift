//
//  LocalController.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/13.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit
//import SnapKit

class LocalController: UIViewController {

    lazy var whiteBgView : UIView = {
        let y : CGFloat = 300
        let width = UIApplication.shared().keyWindow!.screen.bounds.size.width
        let height = UIApplication.shared().keyWindow!.screen.bounds.size.height - y
        let view = UIView(frame: CGRect(x: 0, y: y, width: width, height: height))
        view.backgroundColor = UIColor.white()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/// setup
extension LocalController {

    private func setup() {

        modalPresentationStyle = .popover
        view.backgroundColor = UIColor.clear()

        addBlurEffectView()

//        whiteBgView.

    }

    private func addBlurEffectView() {

        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = view.frame
        effectView.alpha = 0.8
        effectView.isOpaque = false
        view.addSubview(effectView)

    }

}
