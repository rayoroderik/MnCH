//
//  kaderMainTableViewCell.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class kaderMainTableViewCell: UITableViewCell {
    @IBOutlet weak var childImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUmur: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
