//
//  TextLabelCell.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 10/10/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class TextLabelCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var detailLabel:UILabel!
    @IBOutlet weak var contentViewHolder:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentViewHolder.backgroundColor = FontColor.borderColor;
        contentViewHolder.clipsToBounds = true;
        contentViewHolder.showBorder(width: RadiusSize.Zero, color: FontColor.clear, cornerRadius: RadiusSize.Five);
        
        titleLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Twelve, fontColor: FontColor.darkBlue)
        detailLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Fourteen, fontColor: FontColor.black)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
