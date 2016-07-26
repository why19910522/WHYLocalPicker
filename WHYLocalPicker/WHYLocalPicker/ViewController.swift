//
//  ViewController.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/14.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lb: UILabel!

    lazy var localController: LocalController = {

        let local = LocalController()
        local.localTitleColor = UIColor.blueColor()
        local.customListCellClass = CustomLIstCell.classForCoder()
        return local
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickBtn() {

        view.addSubview(localController.view)
//        presentViewController(localController, animated: true, completion: nil)

    }

}

