//
//  CustomLIstCell.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/25.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

class CustomLIstCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = "\(arc4random_uniform(100))"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
