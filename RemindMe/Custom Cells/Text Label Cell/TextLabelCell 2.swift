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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.configureWith(fontName: FontName.OpenSansRegular, fontSize: FontSize.Fourteen, fontColor: FontColor.black)
        detailLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Fourteen, fontColor: FontColor.grayColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
