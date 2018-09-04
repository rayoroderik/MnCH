//
//  detailKaderTableViewCell.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class detailKaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgBaby: UIImageView!
    @IBOutlet weak var lblBabyName: UILabel!
    @IBOutlet weak var lblBabyAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgBaby.layer.cornerRadius = 30
        self.imgBaby.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
