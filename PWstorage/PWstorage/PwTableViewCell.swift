//
//  PwTableViewCell.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-10-30.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit

class PwTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var imageForCell: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
