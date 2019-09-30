//
//  TableViewHolder.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class TableViewHolder: UIView {

    @IBOutlet weak var tableView:UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViewHolder()
    }
    
    private func configureViewHolder() {
        self.roundCorners([.topLeft, .topRight], radius: RadiusSize.Twenty)
        self.backgroundColor = FontColor.lightGrayColor
    }
}
