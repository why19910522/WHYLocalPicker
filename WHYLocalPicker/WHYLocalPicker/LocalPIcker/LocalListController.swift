//
//  LocalListController.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/13.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

let cellId = "LocalListCell"

class LocalListController: UITableViewController {

    var cellClass : AnyClass?


    override func viewDidLoad() {
        super.viewDidLoad()

        if let cellClass = self.cellClass {
            tableView.registerClass(cellClass, forCellReuseIdentifier: cellId)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)

        if cellClass != nil {
            return cell!
        }

        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "测试" + "\(arc4random_uniform(32))"
        return cell!
    }


}


extension UIColor {
    public class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
}
