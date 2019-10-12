//
//  EmptyTaskCell.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 10/10/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class EmptyTaskCell: UITableViewCell {
    
    @IBOutlet private weak var contentViewHolder:UIView!
    @IBOutlet private weak var emptyLabel:UILabel!
    @IBOutlet private weak var addButton:UIButton!
    @IBOutlet private weak var emptyImageView:UIImageView!
    
    var didTapAdd:(()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = FontColor.clear
        self.backgroundColor = FontColor.backGroundColor
        
        contentView.clipsToBounds = true;
        
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.roundCorners([.topLeft, .topRight], radius: RadiusSize.Twenty)
    }
    
    private func configureView() {
        emptyLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Sixteen, fontColor: .lightGray)
        addButton.configureWith(title: Constants.AddTask, titleColor: FontColor.white, backgroundColor: FontColor.lightGrayColor, cornerRadius: RadiusSize.Twenty)
    }

    @IBAction private func handleAddTap(_ sender:UIButton) {
        if let handler = didTapAdd {
            handler()
        }
    }
}
