//
//  staffMainTableViewCell.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class staffMainTableViewCell: UITableViewCell {
    @IBOutlet weak var lblKader: UILabel!
    @IBOutlet weak var imgKader: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgKader.layer.cornerRadius = imgKader.layer.frame.height/2
        imgKader.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
