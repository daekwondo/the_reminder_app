//
//  TableViewHolder.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class ViewHolder: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViewHolder()
    }
    
    func addDummyView(_ subView:UIView) {
        let screenSize = UIScreen.main.bounds.size;
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: -screenSize.height))
        view.backgroundColor = FontColor.backGroundColor
        subView.addSubview(view)
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
