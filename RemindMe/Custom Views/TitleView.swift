//
//  TitleViewHolder.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var dismissButton:UIButton?
    
    var dismissView:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        backgroundColor = FontColor.clear
        titleLabel.configureWith(fontName: FontName.OpenSansSemiBold, fontSize: FontSize.Eighteen, fontColor: FontColor.white)
    }
    
    private func configureButton() {
        guard let button = dismissButton else {
            return
        }
        
        button.configureWith(imageName: ImageName.Back, tintColor: FontColor.white, backgroundColor: FontColor.clear, cornerRadius: RadiusSize.Zero);
    }
    
    @IBAction func handleDismissView() {
        if let handler = dismissView {
            handler();
        }
    }
}
