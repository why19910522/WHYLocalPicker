//
//  ViewController.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/14.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var localController: LocalController = {

        let local = LocalController()

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


}

