//
//  TitleViewHolder.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var dismissButton:UIButton?
    @IBOutlet weak var editButton:UIButton?
    
    var dismissView:(() -> Void)?
    var editAction:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        backgroundColor = FontColor.clear
        titleLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Eighteen, fontColor: FontColor.white)
    }
    
    func configureEditButton(forStatus status:TaskStatus) {
        var title = Constants.EmptyString
        var hide = true
        
        if status == .viewing {
            hide = false;
            title = Constants.Edit
        }
        
        editButton?.isHidden = hide
        editButton?.setTitle(title, for: .normal)
    }
    
    private func configureButton() {
        if let button = dismissButton {
            button.configureWith(imageName: ImageName.Back, tintColor: FontColor.white, backgroundColor: FontColor.clear, cornerRadius: RadiusSize.Zero);
        }
        
        if let button = editButton {
            button.configureWith(title: ImageName.Edit.capitalizedFirstLetter(), titleColor: FontColor.white, backgroundColor: FontColor.clear, cornerRadius:0);
        }
    }
    
    @IBAction func handleDismissView() {
        if let handler = dismissView {
            handler();
        }
    }
    
    @IBAction func handleEditAction() {
        if let handler = editAction {
            handler();
        }
    }
}
