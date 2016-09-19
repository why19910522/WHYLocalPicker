//
//  LocalListController.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/13.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

private let cellId = "LocalListCell"

protocol LocalListDelegate {

    func localListController(controller : LocalListController, didSelectRowAtIndexPath indexPath: NSIndexPath)

    func localListController(controller : LocalListController, didDeselectRowAtIndexPath indexPath: NSIndexPath)

}

class LocalListController: UITableViewController {

    var cellClass : AnyClass?

    var deleget : LocalListDelegate?

    var dataModel : AnyObject?


    private var selectedIndexPath : NSIndexPath?

    func deselectedCell() {
        if let lastIndexPath = selectedIndexPath {
            self.tableView(tableView, didDeselectRowAtIndexPath : lastIndexPath)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension LocalListController {
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
        cell?.textLabel?.text = "测试" + "\(arc4random_uniform(1000))"
        cell?.selectionStyle = .None
        return cell!
    }
}

extension LocalListController {
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let lastIndexPath = selectedIndexPath {
            self.tableView(tableView, didDeselectRowAtIndexPath : lastIndexPath)
        }

        if let localListDeleget = deleget {
            localListDeleget.localListController(self, didSelectRowAtIndexPath: indexPath)
            selectedIndexPath = indexPath
        }
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let localListDeleget = deleget {
            localListDeleget.localListController(self, didDeselectRowAtIndexPath: indexPath)
        }
    }
}

extension LocalListController {
    private func setup() {
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
//        tableView.allowsSelection = false

        if let cellClass = self.cellClass {
            tableView.registerClass(cellClass, forCellReuseIdentifier: cellId)
        }
    }
}


extension UIColor {
    public class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
}
