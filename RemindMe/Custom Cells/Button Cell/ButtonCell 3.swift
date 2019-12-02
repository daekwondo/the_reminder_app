//
//  ButtonCell.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 11/7/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    @IBOutlet weak var contentViewHolder:UIView!
    @IBOutlet weak var createButton:UIButton!
    var didTapCreateReminder:(()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        createButton.configureWith(title: Constants.CreateReminder, titleColor: FontColor.white, backgroundColor: FontColor.darkBlue, cornerRadius: 22)
    }
    
    @IBAction private func createReminderTapped(_ sender:UIButton) {
        if let handler = didTapCreateReminder {
            handler()
        }
    }
}
