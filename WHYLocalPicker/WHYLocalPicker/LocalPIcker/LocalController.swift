//
//  LocalController.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/13.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit
import SnapKit

private let mainScreenWidth = UIScreen.mainScreen().bounds.size.width

class LocalController: UIViewController {

// MARK: - public var
    /// set localTitleFont ,default is 14
    var localTitleFont : UIFont? {
        didSet {
            titleLb.font = localTitleFont
        }
    }
    /// set localTitleColor ,default is blackColor
    var localTitleColor : UIColor? {
        didSet {
            titleLb.textColor = localTitleColor
        }
    }
    /// set localTitleText ,default is "所在地区"
    var localTitleText : String? {
        didSet {
            titleLb.text = localTitleText
        }
    }
    /// set customCloseBtn, the customCloseBtn dosen`t need to take a action
    var customCloseBtn : UIButton?
    /// set customIndicatorButtons, the customIndicatorButtons need to have their own action
    var customIndicatorButtons : [LocalIndicatorButton]?
    /// set indicatorLineColor ,default is redColor
    var indicatorLineColor : UIColor?
    /// set customListCell ,if you want to customize the list cell ,please user this var
    var customListCellClass : AnyClass?






// MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - private lazy var
    private lazy var indicatorSep : UIView = {
        let view = UIView()
        view.backgroundColor = self.indicatorLineColor ?? UIColor.redColor()
        return view
    }()

    private lazy var listControllers : [LocalListController] = {
        var controllers = [LocalListController]()

        for i in 0..<self.indicatorButtons.count {
            let controller = LocalListController()
            controller.cellClass = self.customListCellClass
            controllers.append(controller)
        }

        return controllers
    }()

    private lazy var horizontalScrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = UIColor.cyanColor()
        scroll.pagingEnabled = true
        scroll.delegate = self
        return scroll
    }()

    private lazy var indicatorButtons : [LocalIndicatorButton] = {

        if let btns = self.customIndicatorButtons {
            return btns
        }

        var arr = [LocalIndicatorButton]()
        for i in 0..<4 {
            let btn = LocalIndicatorButton()
            btn.addTarget(self, action: #selector(LocalController.clickIndicatorButton(_:)), forControlEvents: .TouchUpInside)
            arr.append(btn)
        }
        return arr
    }()

    private lazy var blurView : UIVisualEffectView = {
        let blur = UIBlurEffect(style: .Dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = self.view.frame
        effectView.alpha = 0.8
        effectView.opaque = false
        return effectView
    }()

    private lazy var whiteBgView : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()

    private lazy var titleLb : UILabel = {
        let lb = UILabel();
        lb.text = self.localTitleText ?? "所在地区"
        lb.textColor = self.localTitleColor ?? UIColor.blackColor()
        lb.textAlignment = .Center
        lb.font = self.localTitleFont ?? UIFont.systemFontOfSize(14)
        return lb
    }()

    private lazy var closeBtn : UIButton = {

        if let customBtn = self.customCloseBtn {
            customBtn.addTarget(self, action: #selector(LocalController.clickCloseBtn), forControlEvents: .TouchUpInside)
            return customBtn
        }

        let btn = UIButton()
        btn.setTitle("取消", forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: #selector(LocalController.clickCloseBtn), forControlEvents: .TouchUpInside)
        return btn
    }()

    private lazy var sep : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor()
        return view
    }()

// MARK: - private var
    private var selectedIndicatorBtn : UIButton?

    private var indicatorIndex : Int {
        get {
            return Int(self.horizontalScrollView.contentOffset.x / mainScreenWidth)
        }
    }


}

// MARK: - button click
extension LocalController {

    @objc private func clickIndicatorButton(btn : UIButton) {
        if customIndicatorButtons != nil {
            return
        }

        var index : CGFloat = 0.0

        switch btn {
            case indicatorButtons[0]:
                index = 0.0
                break
            case indicatorButtons[1]:
                index = 1.0
                break
            case indicatorButtons[2]:
                index = 2.0
                break
            case indicatorButtons[3]:
                index = 3.0
                break
            default:
                break
        }

        horizontalScrollView.setContentOffset(CGPointMake(index * mainScreenWidth, 0), animated: true)

        selectedIndicatorBtn?.selected = false
        selectedIndicatorBtn = btn
        selectedIndicatorBtn?.selected = true

        updateIndicatorSepFrame()

    }

    @objc private func clickCloseBtn() {
        if (view.superview != nil) {
            view.removeFromSuperview()
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        clickCloseBtn()
    }

}

// MARK: - setup
extension LocalController {

    private func updateIndicatorSepFrameWithIndex(index : Int) {
        selectedIndicatorBtn = indicatorButtons[index]
        updateIndicatorSepFrame()
    }

    private func updateIndicatorSepFrame() {

        guard let btn = selectedIndicatorBtn else {
            return
        }

        let indicatorW = btn.frame.size.width
        let indicatorX = btn.frame.origin.x
        let indicatorY = CGRectGetMaxY(btn.frame)
        let indicatorH : CGFloat = 1.0

        UIView.animateWithDuration(0.3) {
            self.indicatorSep.frame = CGRectMake(indicatorX, indicatorY, indicatorW, indicatorH)
        }

        //        print("\(indicatorW)")
    }

    private func setupUI() {

        modalPresentationStyle = .Custom
        view.backgroundColor = UIColor.clearColor()

        view.addSubview(blurView)

        unowned let weakSelf = self
        let bgTop : CGFloat = 300
        let titleTop : CGFloat = 10
        let right : CGFloat = 10
        let sepTop : CGFloat = 35
        let sepH : CGFloat = 1
        let btnLeft : CGFloat = 10
        let btnH : CGFloat = 20

        view.addSubview(whiteBgView)
        whiteBgView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(weakSelf.view)
            make.top.equalTo(weakSelf.view).offset(bgTop)
        }

        whiteBgView.addSubview(titleLb)
        titleLb.snp_makeConstraints { (make) in
            make.centerX.equalTo(weakSelf.whiteBgView)
            make.top.equalTo(weakSelf.whiteBgView).offset(titleTop)
        }

        whiteBgView.addSubview(closeBtn)
        closeBtn.snp_makeConstraints { (make) in
            make.centerY.equalTo(weakSelf.titleLb)
            make.right.equalTo(weakSelf.whiteBgView).offset(-right)
        }

        whiteBgView.addSubview(sep)
        sep.snp_makeConstraints { (make) in
            make.top.equalTo(titleLb.snp_bottom).offset(sepTop)
            make.left.right.equalTo(whiteBgView)
            make.height.equalTo(sepH)
        }

        for i in 0..<indicatorButtons.count {
            let btn = indicatorButtons[i]
            whiteBgView.addSubview(btn)
            btn.snp_makeConstraints(closure: { (make) in
                if i == 0 {
                    make.left.equalTo(weakSelf.whiteBgView).offset(btnLeft)
                }else {
                    make.left.equalTo(weakSelf.indicatorButtons[i-1].snp_right).offset(btnLeft)
                }
                make.bottom.equalTo(weakSelf.sep.snp_top);
                make.height.equalTo(btnH)
            })
        }

        whiteBgView.addSubview(horizontalScrollView)
        horizontalScrollView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(weakSelf.whiteBgView)
            make.top.equalTo(weakSelf.sep.snp_bottom)
        }

        let tableViewW : CGFloat = UIApplication.sharedApplication().keyWindow!.bounds.size.width
        for i in 0..<listControllers.count {
            let listController = listControllers[i]
            horizontalScrollView.addSubview(listController.tableView)
            listController.tableView.snp_makeConstraints(closure: { (make) in
                if i == 0 {
                    make.left.equalTo(weakSelf.horizontalScrollView)
                }else {
                    make.left.equalTo(weakSelf.listControllers[i-1].tableView.snp_right)
                }
                if i == listControllers.count-1 {
                    make.right.equalTo(weakSelf.horizontalScrollView)
                }
                make.top.bottom.equalTo(weakSelf.horizontalScrollView)
                make.width.equalTo(tableViewW)
                make.height.equalTo(weakSelf.horizontalScrollView)
            })

        }

        whiteBgView.addSubview(indicatorSep)
        let indicatorY : CGFloat = 62
        let indicatorW : CGFloat = 42
        let indicatorH : CGFloat = 1
        indicatorSep.frame = CGRectMake(btnLeft, indicatorY, indicatorW, indicatorH)

    }

}

// MARK: - UIScrollViewDelegate
extension LocalController : UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updateIndicatorSepFrameWithIndex(indicatorIndex)
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updateIndicatorSepFrameWithIndex(indicatorIndex)
    }

}
