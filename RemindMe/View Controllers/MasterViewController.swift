//
//  MasterViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/19/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var titleViewHolder:TitleView!
    @IBOutlet weak var viewHolder:ViewHolder!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.disableDarkMode()
        view.backgroundColor = FontColor.backGroundColor
        viewHolder.addDummyView(tableView)
        self.tableView.keyboardDismissMode = .onDrag
    }
}
