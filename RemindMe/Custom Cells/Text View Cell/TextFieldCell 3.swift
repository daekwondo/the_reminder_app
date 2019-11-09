//
//  TextViewCell.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/19/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var nameField:UITextField!
    @IBOutlet weak var contentViewHolder:UIView!
    
    var updateText:((_ text:String)->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
        
        contentView.clipsToBounds = true
        
        contentViewHolder.backgroundColor = FontColor.borderColor;
        contentViewHolder.clipsToBounds = true;
        contentViewHolder.showBorder(width: RadiusSize.Zero, color: FontColor.clear, cornerRadius: RadiusSize.Five);
        
        titleLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Twelve, fontColor: FontColor.darkBlue)
        nameField.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Fourteen, fontColor: FontColor.black)
    }
}

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let handler = updateText {
            let text = textField.text ?? ""
            handler(text)
        }
    }
}
