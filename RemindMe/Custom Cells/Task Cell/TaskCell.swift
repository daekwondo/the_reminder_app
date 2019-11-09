//
//  TaskCell.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/19/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var intervalLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var indicatorView:UIView!
    
    @IBOutlet weak var contentViewHolder:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentViewHolder.backgroundColor = FontColor.borderColor;
        contentViewHolder.clipsToBounds = true;
        contentViewHolder.showBorder(width: RadiusSize.Zero, color: FontColor.clear, cornerRadius: RadiusSize.Five);
        
        titleLabel.configureWith(fontName: FontName.OpenSansBold, fontSize: FontSize.Sixteen, fontColor: FontColor.black)
        intervalLabel.configureWith(fontName: FontName.OpenSansRegular, fontSize: FontSize.Twelve, fontColor: FontColor.grayColor)
        dateLabel.configureWith(fontName: FontName.OpenSansRegular, fontSize: FontSize.Twelve, fontColor: FontColor.grayColor)
        
        indicatorView.showBorder(width: RadiusSize.Zero, color: FontColor.green, cornerRadius: 4);
    }
    
    func configure(forTask task:Tasks) {
        titleLabel.text = task.name
        intervalLabel.text = task.interval.toString(checkPlural: true)
        dateLabel.text = task.startDate.toString()
        
        let color = task.repeats ? FontColor.green : FontColor.red
        indicatorView.backgroundColor = color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
