//
//  AddViewHolder.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class AddView: UIView {
    
    @IBOutlet weak var addImageView:UIImageView!

    var handleAddTask:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = addTapGesture()
        tapGesture.addTarget(self, action: #selector(addTask))
        
        showBorder(width: 0, color: FontColor.red, cornerRadius: 30)
        addShadow()
        addImageView.loadImage(imageName: ImageName.Add, tintColor: FontColor.white)
    }
    
    @objc func addTask() {
        if let handler = handleAddTask {
            bounce()
            handler()
        }
    }
}
