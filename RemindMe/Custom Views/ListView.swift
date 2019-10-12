//
//  TableViewHolder.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    @IBOutlet weak var tableView:UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addDummyView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViewHolder()
    }
    
    private func addDummyView() {
        let screenSize = UIScreen.main.bounds.size;
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: -screenSize.height))
        view.backgroundColor = FontColor.backGroundColor
        tableView.addSubview(view)
    }
    
    private func configureViewHolder() {
        self.roundCorners([.topLeft, .topRight], radius: RadiusSize.Twenty)
    }
    
    func barHeight() -> CGFloat {
        var height:CGFloat = 64;
        if #available(iOS 11.0, *) {
          height = 88
        }
        
        return height
    }
}
